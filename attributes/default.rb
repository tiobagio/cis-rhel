default['cis-rhel']['auditd']['backlog'] = 320
default['cis-rhel']['shell']['tmout'] = 600
default['cis-rhel']['cron_mailto'] = nil
default['cis-rhel']['template_path'] = 'cis-rhel'
default['cis-rhel']['bootloader']['password'] = nil
default['cis-rhel']['kernel']['disable_filesystems'] = %w[(cramfs) (freevxfs) (jffs2) (hfs) (hfsplus) (squashfs) (udf) (vfat)]
default['cis-rhel']['kernel']['disable_network_protocols'] = %w[(dccp) (sctp) (tipc) (rds)]
# xccdf_org.cisecurity.benchmarks_rule_5.4.4_Ensure_default_user_umask_is_027_or_more_restrictive
default['cis-rhel']['init']['daemon_umask'] = '027'
# xccdf_org.cisecurity.benchmarks_rule_1.5.1_Ensure_core_dumps_are_restricted
default['sysctl']['params']['fs.suid_dumpable'] = 0
# xccdf_org.cisecurity.benchmarks_rule_1.5.3_Ensure_address_space_layout_randomization_ASLR_is_enabled
default['sysctl']['params']['kernel.randomize_va_space'] = 2
# xccdf_org.cisecurity.benchmarks_rule_3.1.1_Ensure_IP_forwarding_is_disabled
default['sysctl']['params']['net.ipv4.ip_forward'] = 0
# xccdf_org.cisecurity.benchmarks_rule_3.1.2_Ensure_packet_redirect_sending_is_disabled
default['sysctl']['params']['net.ipv4.conf.all.send_redirects'] = 0
default['sysctl']['params']['net.ipv4.conf.default.send_redirects'] = 0
# xccdf_org.cisecurity.benchmarks_rule_3.2.1_Ensure_source_routed_packets_are_not_accepted
default['sysctl']['params']['net.ipv4.conf.all.accept_source_route'] = 0
default['sysctl']['params']['net.ipv4.conf.default.accept_source_route'] = 0
# xccdf_org.cisecurity.benchmarks_rule_3.2.5_Ensure_broadcast_ICMP_requests_are_ignored
default['sysctl']['params']['net.ipv4.icmp_echo_ignore_broadcasts'] = 1
# xccdf_org.cisecurity.benchmarks_rule_3.2.6_Ensure_bogus_ICMP_responses_are_ignored
default['sysctl']['params']['net.ipv4.icmp_ignore_bogus_error_responses'] = 1
# xccdf_org.cisecurity.benchmarks_rule_3.2.7_Ensure_Reverse_Path_Filtering_is_enabled
default['sysctl']['params']['net.ipv4.conf.all.rp_filter'] = 1
default['sysctl']['params']['net.ipv4.conf.default.rp_filter'] = 1
# xccdf_org.cisecurity.benchmarks_rule_3.2.8_Ensure_TCP_SYN_Cookies_is_enabled
default['sysctl']['params']['net.ipv4.tcp_syncookies'] = 1
