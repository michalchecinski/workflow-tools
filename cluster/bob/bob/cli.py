import click

import .bob.wol as wollib


@click.group(context_settings={'obj': {}})
@click.version_option(__version__, '-V', '--version', message='%(prog)s %(version)s')
def cm():
    pass


@cm.command(name='wol')
@click.option('-p', '--profile', help='Named Profile of MAC addresses')
@click.option(
    '-m', 
    '--mac-addresses', 
    help='Specific MAC addresses (comma seperated list)'
)
def wol(profile, mac_addrs):
    try:
        if profile:
            macs = wollib.load_profile(profile)
        elif mac_addrs:
            macs = wollib.load_list(mac_addrs)
    except Exception as error:
        click.secho(f'[Error] Failed to load mac addresses\n{error}', fg='red')

    wollib.wol(macs)

