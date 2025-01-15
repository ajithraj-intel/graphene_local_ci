#!/usr/bin/env python3
import sys
import logging
import glob
from os import path
import os
import pytest
import re

sgx_mode = os.environ.get('SGX')
no_cores = os.environ.get('no_cpu', '8')
os_version = os.environ.get('os_version')
base_os = os.environ.get('base_os')
os_release_id = os.environ.get('os_release_id')
node_label = os.environ.get('node_label')
edmm_mode = os.environ.get('EDMM')
distro_ver = os.environ.get('distro_ver')
ra_type = os.environ.get("RA_TYPE", "none")

class Test_Workload_Results():
    @pytest.mark.examples
    @pytest.mark.skipif(not(int(no_cores) > 16 or sgx_mode == '1'), reason="Run only on server machines, when dDirect is disabled")
    def test_mariadb_workload_gramine_sgx(self):
        # Not is added in the skip condition to improve readability
        # Test Sequence - Spawn mariadb server in background, run mariadb client, print SUCCESS if successfully launched
        # Check if the string "SUCCESS" is present in and client_output which generated after running the Makefile
        assert "SUCCESS" in open("CI-Examples/mariadb/client_output_gramine-sgx", "r").read()
    
    @pytest.mark.examples
    @pytest.mark.skipif(not(int(no_cores) > 16 and sgx_mode == '0'), reason="Run only on server machines, when dDirect is enabled")
    def test_mariadb_workload_gramine_direct(self):
        # Not is added in the skip condition to improve readability
        # Test Sequence - Spawn mariadb server in background, run mariadb client, print SUCCESS if successfully launched
        # Check if the string "SUCCESS" is present in and client_output which generated after running the Makefile
        assert "SUCCESS" in open("CI-Examples/mariadb/client_output_gramine-direct", "r").read()
