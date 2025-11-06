import requests

__version__ = '7.3.2'

class CustomLib(object):

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def make_get_request(self, url, params):
        return requests.get(url=url, params=params)
