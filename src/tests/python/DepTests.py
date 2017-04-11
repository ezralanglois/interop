"""
Unit tests for core functionality for the SWIG binding
"""
import unittest
import os
try:
    from interop import py_interop_run_metrics
except:
    import sys
    sys.path.append(".")
    from interop import py_interop_run_metrics

class DependencyTests(unittest.TestCase):
    """ Unit tests for the core functionality in the binding
    """

    def test_xml_file_not_found_exception(self):
        """
        Test that exceptions can be caught and they have the expected message
        """

        run = py_interop_run_metrics.run_metrics()
        try:
            run.read('file/not/found')
            self.fail("xml_file_not_found_exception should have been thrown")
        except Exception as ex:
            self.assertEqual(str(ex).split('\n')[0], "cannot open file " + os.path.join("file/not/found", "RunInfo.xml"))

if __name__ == '__main__':
    unittest.main()
