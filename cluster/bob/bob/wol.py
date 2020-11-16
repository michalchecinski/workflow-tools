# Original code copied from: https://gist.github.com/rschuetzler/8854764
import socket
import struct

from contextlib import closing


def validate_mac_address(mac_addr: str):
    try:
        assert len(mac_addr) == 17
        assert mac_addr.count(':') == 5
    except AssertionError:
        raise Exception(f'[!] Malformed MAC address: {mac_addr}')


def load_profile(profile: str) -> list:
    raise NotImplementedError('[*] wol.load_profile is not yet implemented')


def load_list(mac_addrs: str) -> list:
    macs = mac_addrs.split(',')

    for mac in macs:
        validate_mac_addresses(mac)

    return macs


def generate_magic_packet(mac_address: str) -> str:
    ''' Create magic packet with given macAddress
    '''
    split_mac = str.split(mac_address,':')

    # Pack together the sections of the MAC address as binary hex
    hex_mac = struct.pack(
        'BBBBBB',
        int(split_mac[0], 16),
        int(split_mac[1], 16),
        int(split_mac[2], 16),
        int(split_mac[3], 16),
        int(split_mac[4], 16),
        int(split_mac[5], 16)
    )

    return '\xff' * 6 + hex_mac * 16


def send_packet(packet: str, dest_ip: str, dest_port: int):
    ''' Create the socket connection and send the packet
    '''
    with closing(socket.socket(socket.AF_INET, socket.SOCK_DGRAM)) as s:
        s.sendto(packet,(dest_ip,dest_port))


def wol(mac_address: list, dest_ip: str, dest_port: int = 7) -> str:
    packet = generate_magic_packet(mac_address)
    send_packet(packet, dest_ip, dest_port)
    return f'Packet successfully sent to {mac_address}'

