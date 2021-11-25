from mstodo import auth, icons, util


def filter(args):
    util.workflow().add_item(
        'Are you sure?',
        'You will need to log in to a Microsoft account to continue using the workflow',
        arg=' '.join(args),
        valid=True,
        icon=icons.CHECKMARK
    )

    util.workflow().add_item(
        'Nevermind',
        autocomplete='',
        icon=icons.CANCEL
    )

def commit(args, modifier=None):
    auth.deauthorise()
    util.workflow().clear_data()
    util.workflow().clear_cache()

    print('You are now logged out')
