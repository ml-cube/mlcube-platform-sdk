"""
Test module
"""

from mlcube_platform_sdk.base_package.base import my_func


def test_myfunc():
    """Test function"""
    assert my_func(1, 2) == 3
