        -Darch_libdir=$(ARCH_LIBDIR) \
        -Duid=$(UID) \
        -Dgid=$(GID) \
        $< >$@

# Make on Ubuntu <= 20.04 doesn't support "Rules with Grouped Targets" (`&:`),
# for details on this workaround see
# https://github.com/gramineproject/gramine/blob/e8735ea06c/CI-Examples/helloworld/Makefile
mysqld.manifest.sgx mysqld.sig: sgx_sign
        @:

.INTERMEDIATE: sgx_sign
sgx_sign: mysqld.manifest
	gramine-sgx-sign \
	--manifest $< \
	--output $<.sgx

.PHONY: install-mariadb
install-mariadb:
	sudo apt update
	sudo apt install -y mariadb-server mariadb-client
	sudo chmod -R 777 /var/run/mysqld
	sudo chmod -R 777 /var/lib/mysql

.PHONY: remove-mariadb
remove-mariadb:
	sudo systemctl stop mariadb
	sudo apt remove --purge -y mariadb-server
	sudo apt remove --purge -y mariadb-client
	sudo apt autoremove --purge -y
	sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql /var/log/mariadb /var/cache/mysql
