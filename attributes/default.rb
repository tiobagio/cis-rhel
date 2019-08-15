## Recipe::aide
default['cron_mailto'] = nil

## Recipe::auditd
# 4.1.1.2_Ensure_system_is_disabled_when_audit_logs_are_full
default['auditd']['admin_space_left_action'] = 'halt'
default['auditd']['space_left_action'] = 'email'
default['auditd']['action_mail_acct'] = 'root'
# 4.1.1.3_Ensure_audit_logs_are_not_automatically_deleted
default['auditd']['max_log_file_action'] = 'keep_logs'
# 4.1.4_Ensure_events_that_modify_date_and_time_information_are_collected
default['auditd']['collect_events_that_modify_date_and_time'] = [
    '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change',
    '-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change',
    '-a always,exit -F arch=b64 -S clock_settime -k time-change',
    '-a always,exit -F arch=b32 -S clock_settime -k time-change',
    '-w /etc/localtime -p wa -k time-change',
]
# 4.1.5_Ensure_events_that_modify_usergroup_information_are_collected
default['auditd']['collect_events_that_modify_usergroup'] = [
    '-w /etc/group -p wa -k identity',
    '-w /etc/passwd -p wa -k identity',
    '-w /etc/gshadow -p wa -k identity',
    '-w /etc/shadow -p wa -k identity',
    '-w /etc/security/opasswd -p wa -k identity',
]
# 4.1.6_Ensure_events_that_modify_the_systems_network_environment_are_collected
default['auditd']['collect_events_that_modify_the_systems_network_environment'] = [
    '-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale',
    '-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale',
    '-w /etc/issue -p wa -k system-locale',
    '-w /etc/issue.net -p wa -k system-locale',
    '-w /etc/hosts -p wa -k system-locale',
    '-w /etc/sysconfig/network -p wa -k system-locale',
    '-w /etc/sysconfig/network-scripts/ -p wa -k system-locale',
]
# 4.1.7_Ensure_events_that_modify_the_systems_Mandatory_Access_Controls_are_collected
default['auditd']['collect_events_that_modify_the_systems_MAC'] = [
    '-w /etc/selinux/ -p wa -k MAC-policy',
    '-w /usr/share/selinux/ -p wa -k MAC-policy',
]
# 4.1.8_Ensure_login_and_logout_events_are_collected
default['auditd']['collect_login_and_logout_events'] = [
    '-w /var/log/lastlog -p wa -k logins',
    '-w /var/run/faillock/ -p wa -k logins',
]
# 4.1.9_Ensure_session_initiation_information_is_collected
if node['platform_version'].to_i == 6
  default['auditd']['collect_session_initiation_information'] = [
      '-w /var/run/utmp -p wa -k session',
      '-w /var/log/wtmp -p wa -k session',
      '-w /var/log/btmp -p wa -k session',
  ]
elsif node['platform_version'].to_i == 7
  default['auditd']['collect_session_initiation_information'] = [
      '-w /var/run/utmp -p wa -k session',
      '-w /var/log/wtmp -p wa -k logins',
      '-w /var/log/btmp -p wa -k logins',
  ]
end
# 4.1.10_Ensure_discretionary_access_control_permission_modification_events_are_collected
default['auditd']['collect_DAC_permission_modification_events'] = [
    '-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
]
# 4.1.11_Ensure_unsuccessful_unauthorized_file_access_attempts_are_collected
default['auditd']['collect_unsuccessful_unauthorized_file_access_attempts'] = [
    '-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
    '-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
    '-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
    '-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
]
# 4.1.13_Ensure_successful_file_system_mounts_are_collected
default['auditd']['collect_successful_file_system_mounts'] = [
    '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
    '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
]
# 4.1.14_Ensure_file_deletion_events_by_users_are_collected
if node['platform_version'].to_i == 6
  default['auditd']['collect_file_deletion_events_by_users'] = [
      '-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete',
      '-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete',
  ]
elsif node['platform_version'].to_i == 7
  default['auditd']['collect_file_deletion_events_by_users'] = [
      '-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
      '-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
  ]
end
# 4.1.15_Ensure_changes_to_system_administration_scope_sudoers_is_collected
default['auditd']['collect_changes_to_system_admin_scope_sudoers'] = [
    '-w /etc/sudoers -p wa -k scope',
    '-w /etc/sudoers.d/ -p wa -k scope',
]
# 4.1.16_Ensure_system_administrator_actions_sudolog_are_collected
default['auditd']['collect_system_admin_scope_actions_sudolog'] = [
    '-w /var/log/sudo.log -p wa -k actions',
]
# 4.1.17_Ensure_kernel_module_loading_and_unloading_is_collected
default['auditd']['collect_kernel_module_loading_and_unloading'] = [
    '-w /sbin/insmod -p x -k modules',
    '-w /sbin/rmmod -p x -k modules',
    '-w /sbin/modprobe -p x -k modules',
    '-a always,exit -F arch=b32 -S init_module -S delete_module -k modules',
    '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules',
]
# 4.1.18_Ensure_the_audit_configuration_is_immutable
default['auditd']['audit_configuration_is_immutable'] = '-e 2'
# Template::auditd.rules
default['auditd']['backlog'] = 320

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

## Recipe::time_sync
default['ntp']['install'] = false
default['chrony']['install'] = true
default['ntp']['servers'] = %w(0.rhel.pool.ntp.org 1.rhel.pool.ntp.org 2.rhel.pool.ntp.org 3.rhel.pool.ntp.org)
default['ntp']['restrict_default'] = 'kod nomodify notrap nopeer noquery'
