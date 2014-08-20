#!/usr/bin/make
# WARN: gmake syntax
########################################################
# Makefile for stig-fix
#
# useful targets:
#   make clean ---------------- cleanup
#   make rpm  ----------------- produce RPM
#   make sdist ---------------- make source distribution

########################################################
# variable section

NAME = stig-fix
OS = $(shell uname -s)

# VERSION file provides one place to update the software version
VERSION := $(shell cat VERSION)

# Get the branch information from git
ifneq ($(shell which git),)
GIT_DATE := $(shell git log -n 1 --format="%ai")
endif

DATE := $(shell date --utc --date="$(GIT_DATE)" +%Y%m%d%H%M)

# RPM build parameters
RPMSPECDIR= packaging/rpm
RPMSPEC = $(RPMSPECDIR)/stig-fix.spec
RPMDIST = $(shell rpm --eval '%{?dist}')
RPMRELEASE = 1
ifneq ($(OFFICIAL),yes)
    RPMRELEASE = 0.git$(DATE)
endif
RPMNVR = "$(NAME)-$(VERSION)-$(RPMRELEASE)$(RPMDIST)"

########################################################

clean:
	@echo "Cleaning up RPM building stuff"
	rm -rf MANIFEST dist rpm-build

sdist: clean
	@echo "Make distribution"
	@mkdir -p dist/$(NAME)-$(VERSION)/
	@ln -s ../../cat1 dist/$(NAME)-$(VERSION)/cat1
	@ln -s ../../cat2 dist/$(NAME)-$(VERSION)/cat2
	@ln -s ../../cat3 dist/$(NAME)-$(VERSION)/cat3
	@ln -s ../../cat4 dist/$(NAME)-$(VERSION)/cat4
	@ln -s ../../config dist/$(NAME)-$(VERSION)/config
	@ln -s ../../doc dist/$(NAME)-$(VERSION)/doc
	@ln -s ../../manual dist/$(NAME)-$(VERSION)/manual
	@ln -s ../../misc dist/$(NAME)-$(VERSION)/misc
	@cp apply.sh dist/$(NAME)-$(VERSION)/
	@cp checkpoint.sh dist/$(NAME)-$(VERSION)/
	@cp AUTHORS dist/$(NAME)-$(VERSION)/
	@cp CHANGELOG dist/$(NAME)-$(VERSION)/
	@cp COPYING dist/$(NAME)-$(VERSION)/
	@cp LICENSE dist/$(NAME)-$(VERSION)/
	@cp Makefile dist/$(NAME)-$(VERSION)/
	@cp README dist/$(NAME)-$(VERSION)/
	@cp toggle_ipv6.sh dist/$(NAME)-$(VERSION)/
	@cp toggle_nousb.sh dist/$(NAME)-$(VERSION)/
	@cp toggle_udf.sh dist/$(NAME)-$(VERSION)/
	@cp toggle_usb.sh dist/$(NAME)-$(VERSION)/
	@echo "Creating tar ball"
	@tar -C dist -chf ./dist/$(NAME)-$(VERSION).tar $(NAME)-$(VERSION)
	@gzip -f9 ./dist/$(NAME)-$(VERSION).tar
    
rpmcommon: clean sdist
	@mkdir -vp rpm-build
	@cp -v dist/*.gz rpm-build/
	@sed -e 's#^Version:.*#Version: $(VERSION)#' -e 's#^Release:.*#Release: $(RPMRELEASE)%{?dist}#' $(RPMSPEC) >rpm-build/$(NAME).spec

##
# Untested
#srpm: rpmcommon
#	@rpmbuild --define "_topdir %(pwd)/rpm-build" \
#	--define "_builddir %{_topdir}" \
#	--define "_rpmdir %{_topdir}" \
#	--define "_srcrpmdir %{_topdir}" \
#	--define "_specdir $(RPMSPECDIR)" \
#	--define "_sourcedir %{_topdir}" \
#	-bs rpm-build/$(NAME).spec
#	@rm -f rpm-build/$(NAME).spec
#	@echo "#############################################"
#	@echo "stig-fix SRPM is built:"
#	@echo "    rpm-build/$(RPMNVR).src.rpm"
#	@echo "#############################################"

rpm: rpmcommon
	@rpmbuild --define "_topdir %(pwd)/rpm-build" \
	--define "_builddir %{_topdir}" \
	--define "_rpmdir %{_topdir}" \
	--define "_srcrpmdir %{_topdir}" \
	--define "_specdir $(RPMSPECDIR)" \
	--define "_sourcedir %{_topdir}" \
	--define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" \
	-ba rpm-build/$(NAME).spec
	@rm -f rpm-build/$(NAME).spec
	@echo "#############################################"
	@echo "stig-fix RPM is built:"
	@echo "    rpm-build/$(RPMNVR).noarch.rpm"
	@echo "#############################################"

