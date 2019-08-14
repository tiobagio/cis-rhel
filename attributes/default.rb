## Recipe::aide
default['cron_mailto'] = nil

## Recipe::grub
# 1.4.2_Ensure_bootloader_password_is_set
default['bootloader']['password'] = nil

# Recipe::kernel_modules
# 1.1.1.1_Ensure_mounting_of_cramfs_filesystems_is_disabled
# 1.1.1.2_Ensure_mounting_of_freevxfs_filesystems_is_disabled
# 1.1.1.3_Ensure_mounting_of_jffs2_filesystems_is_disabled
# 1.1.1.4_Ensure_mounting_of_hfs_filesystems_is_disabled
# 1.1.1.5_Ensure_mounting_of_hfsplus_filesystems_is_disabled
# 1.1.1.6_Ensure_mounting_of_squashfs_filesystems_is_disabled
# 1.1.1.7_Ensure_mounting_of_udf_filesystems_is_disabled
# 1.1.1.8_Ensure_mounting_of_FAT_filesystems_is_disabled
default['kernel']['disable_filesystems'] = %w(cramfs freevxfs jffs2 hfs hfsplus squashfs udf vfat)
# 3.5.1 Ensure DCCP is disabled
# 3.5.2 Ensure SCTP is disabled
# 3.5.4_Ensure_TIPC_is_disabled
# 3.5.3_Ensure_RDS_is_disabled
default['kernel']['disable_network_protocols'] = %w(dccp sctp tipc rds)

## Recipe::login_defs
default['env']['extra_user_paths'] = []
default['env']['umask'] = '077'
# # 5.4.1.1_Ensure_password_expiration_is_365_days_or_less
default['auth']['pw_max_age'] = 365
# 5.4.1.2_Ensure_minimum_days_between_password_changes_is_7_or_mor
default['auth']['pw_min_age'] = 7
# 5.4.1.3_Ensure_password_expiration_warning_days_is_7_or_more
default['auth']['pw_warn_age'] = 7
# 5.4.1.4_Ensure_inactive_password_lock_is_30_days_or_less
default['auth']['pw_inactive'] = 30
default['auth']['retries'] = 5
default['auth']['lockout_time'] = 600 # 10min
default['auth']['maildir'] = '/var/mail'
default['auth']['timeout'] = 60
default['auth']['allow_homeless'] = false
default['auth']['root_ttys'] = %w(console tty1 tty2 tty3 tty4 tty5 tty6)
default['auth']['uid_min'] = 1000
default['auth']['uid_max'] = 60000
default['auth']['gid_min'] = 1000
default['auth']['gid_max'] = 60000
default['auth']['sys_uid_max'] = 999
default['auth']['sys_gid_max'] = 999

## Recipe::minimize_access
# 5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
default['init']['umask'] = '027'
# 5.4.5_Ensure_default_user_shell_timeout_is_900_seconds_or_less
default['shell']['tmout'] = 600
# 6.1.10_Ensure_no_world_writable_files_exist
default['filesystem']['non_world_writable_files'] = []

## Recipe::ntp
default['ntp']['install'] = false
default['chrony']['install'] = true
default['ntp']['servers'] = %w(0.rhel.pool.ntp.org 1.rhel.pool.ntp.org 2.rhel.pool.ntp.org 3.rhel.pool.ntp.org)
default['ntp']['restrict_default'] = 'kod nomodify notrap nopeer noquery'

## Recipe::ssh
default['ssh-hardening']['ssh']['server']['deny_users'] = []
default['ssh-hardening']['ssh']['server']['allow_users'] = []
default['ssh-hardening']['ssh']['server']['deny_groups'] = []
default['ssh-hardening']['ssh']['server']['allow_groups'] = []

## Recipe::sysctl
# 1.5.1_Ensure_core_dumps_are_restricted
default['kernel']['enable_core_dump'] = false
default['sysctl']['params']['fs.suid_dumpable'] = 0
# 1.5.3_Ensure_address_space_layout_randomization_ASLR_is_enabled
default['sysctl']['params']['kernel.randomize_va_space'] = 2
# 3.1.1_Ensure_IP_forwarding_is_disabled
default['sysctl']['params']['net.ipv4.ip_forward'] = 0
# 3.1.2_Ensure_packet_redirect_sending_is_disabled
default['sysctl']['params']['net.ipv4.conf.all.send_redirects'] = 0
default['sysctl']['params']['net.ipv4.conf.default.send_redirects'] = 0
# 3.2.1_Ensure_source_routed_packets_are_not_accepted
default['sysctl']['params']['net.ipv4.conf.all.accept_source_route'] = 0
default['sysctl']['params']['net.ipv4.conf.default.accept_source_route'] = 0
# 3.2.2_Ensure_ICMP_redirects_are_not_accepted
default['sysctl']['params']['net.ipv4.conf.all.accept_redirects'] = 0
default['sysctl']['params']['net.ipv4.conf.default.accept_redirects'] = 0
# 3.2.3_Ensure_secure_ICMP_redirects_are_not_accepted
default['sysctl']['params']['net.ipv4.conf.all.secure_redirects'] = 0
default['sysctl']['params']['net.ipv4.conf.default.secure_redirects'] = 0
# 3.2.4_Ensure_suspicious_packets_are_logged
default['sysctl']['params']['net.ipv4.conf.all.log_martians'] = 1
default['sysctl']['params']['net.ipv4.conf.default.log_martians'] = 1
# 3.2.5_Ensure_broadcast_ICMP_requests_are_ignored
default['sysctl']['params']['net.ipv4.icmp_echo_ignore_broadcasts'] = 1
# 3.2.6_Ensure_bogus_ICMP_responses_are_ignored
default['sysctl']['params']['net.ipv4.icmp_ignore_bogus_error_responses'] = 1
# 3.2.7_Ensure_Reverse_Path_Filtering_is_enabled
default['sysctl']['params']['net.ipv4.conf.all.rp_filter'] = 1
default['sysctl']['params']['net.ipv4.conf.default.rp_filter'] = 1
# 3.2.8_Ensure_TCP_SYN_Cookies_is_enabled
default['sysctl']['params']['net.ipv4.tcp_syncookies'] = 1
# 3.3.1_Ensure_IPv6_router_advertisements_are_not_accepted
default['sysctl']['params']['net.ipv6.conf.all.accept_ra'] = 0
default['sysctl']['params']['net.ipv6.conf.default.accept_ra'] = 0
# 3.3.2_Ensure_IPv6_redirects_are_not_accepted
default['sysctl']['params']['net.ipv6.conf.all.accept_redirects'] = 0
default['sysctl']['params']['net.ipv6.conf.default.accept_redirects'] = 0

# Template::auditd.rules
default['auditd']['backlog'] = 320
