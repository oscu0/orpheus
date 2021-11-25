# encoding: utf-8

import re

from mstodo import auth, icons
from mstodo.util import relaunch_alfred, workflow

ACTION_PATTERN = re.compile(r'^\W+', re.UNICODE)


def filter(args):
    getting_help = False

    if len(args) > 0:
        action = re.sub(ACTION_PATTERN, '', args[0])
        getting_help = action and 'help'.find(action) == 0

    if not getting_help:
        workflow().add_item(
            'Please log in',
            'Authorise Alfred ToDo Workflow to use your Microsoft account',
            valid=True, icon=icons.ACCOUNT
        )

    # If the auth process has started, allow user to paste a key manually
    if getting_help:
        workflow().add_item(
            'A "localhost" page appeared in my web browser',
            u'Paste the full link from your browser above then press return, td:help http://localhost:6200/…',
            arg=' '.join(args), valid=True, icon=icons.LINK
        )
        workflow().add_item(
            'I need to log in to a different account',
            'Go to microsoft.com in your browser and sign out of your account first',
            arg='-about mstodo', valid=True, icon=icons.ACCOUNT
        )
        workflow().add_item(
            'Other issues?',
            'See outstanding issues and report your own bugs or feedback',
            arg='-about issues', valid=True, icon=icons.HELP
        )
    else:
        workflow().add_item(
            'Having trouble?',
            autocomplete='-help ', valid=False, icon=icons.HELP
        )

    if not getting_help:
        workflow().add_item(
            'About',
            'Learn about the workflow and get support',
            autocomplete='-about ',
            icon=icons.INFO
        )

def commit(args, modifier=None):
    command = ' '.join(args).strip()
    manual_verification_url = re.search(r'localhost\S+', command)

    if manual_verification_url:
        auth_status = auth.handle_authorization_url('http://' + manual_verification_url.group())

        if auth_status is True:
            relaunch_alfred()
        elif not auth_status:
            print('Invalid or expired URL, please try again')
    elif not command:
        auth.authorise()
