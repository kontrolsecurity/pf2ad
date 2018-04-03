#!/bin/sh
# Part of pf2ad script - redesigned by kontrol tecnologia


/usr/sbin/pkg bootstrap
/usr/sbin/pkg update

# Lock packages
/usr/sbin/pkg lock pkg
/usr/sbin/pkg lock Kontrol-2.4.3


cat <<EOF > /usr/local/etc/pkg/repos/kontrolsso.conf
kontrolsso: {
    url: "https://github.com/kontrolsecurity/packages/raw/11.1",
    mirror_type: "https",
    enabled: yes
}
EOF

/usr/sbin/pkg update -r kontrolsso
#/usr/sbin/pkg install -r kontrolsso net/samba44 2> /dev/null
/usr/sbin/pkg install -y -r kontrolsso net/samba44

/usr/sbin/pkg unlock pkg
/usr/sbin/pkg unlock Kontrol-2.4.3


rm -rf /usr/local/etc/pkg/repos/kontrolsso.conf
/usr/sbin/pkg update


echo "Setting Winbind Permissions"
mkdir -p /var/db/samba4/winbindd_privileged
chown root:proxy /var/db/samba4/winbindd_privileged
chmod -R 0750 /var/db/samba4/winbindd_privileged

/etc/rc.d/ldconfig restart

echo "Done!"