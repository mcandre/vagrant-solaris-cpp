BOX=vagrant-solaris-cpp.box

.PHONY: launch-vm clean-vm clean-boxes clean-vagrant-metadata

launch-vm: Vagrantfile bootstrap.sh
	vagrant up

test: launch-vm
	vagrant ssh -c "cd /vagrant && g++ -o hello hello.cpp && ./hello"

clean-vm:
	-vagrant destroy -f

clean-boxes:
	-rm -rf *.box

clean-vagrant-metadata:
	-rm -rf .vagrant

clean: clean-boxes clean-vm clean-vagrant-metadata

$(BOX): clean launch-vm
	vagrant package --output $(BOX)
