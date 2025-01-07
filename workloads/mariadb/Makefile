ARCH_LIBDIR ?= /lib/$(shell $(CC) -dumpmachine)
UID ?= $(shell id -u)
GID ?= $(shell id -g)

ifeq ($(DEBUG),1)
GRAMINE_LOG_LEVEL = debug
else
GRAMINE_LOG_LEVEL = error
endif

.PHONY: all
all: mysqld.manifest
ifeq ($(SGX),1)
all: mysqld.manifest.sgx mysqld.sig
endif

mysqld.manifest: mysqld.manifest.template
	gramine-manifest \
        -Dlog_level=$(GRAMINE_LOG_LEVEL) \
        -Darch_libdir=$(ARCH_LIBDIR) \
        -Duid=$(UID) \
        -Dgid=$(GID) \
	-Dentrypoint=/usr/sbin/mysqld \
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
	sudo apt install -y mariadb-server

.PHONY: remove-mariadb
remove-mariadb:
	sudo systemctl stop mariadb
	sudo apt remove --purge -y mariadb-server
	sudo apt remove --purge -y mariadb-client
	sudo apt autoremove --purge -y
	sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql /var/log/mariadb /var/cache/mysql

.PHONY: clean
clean:
	$(RM) *.sig *.manifest.sgx *.manifest
	$(RM) -r /tmp/mysql-data


.PHONY: test-native
test-native:
	sudo chmod -R 755 /var/run/mysqld
	sudo chmod -R 755 /var/lib/mysql
	sudo chown -R mysql:mysql /var/lib/mysql
	sudo chown -R mysql:mysql /run/mysqld
	sudo systemctl stop mysql
	sudo pkill -9 mysqld
	mysqld --skip-grant-tables --bind-address=127.0.0.1 


