include_controls 'cis-rhel7-level1-server' do
  # RHEL 7 controls that are out of scope for remediation
  #
  # 1.2.1 - skipping for now until we add logic RHEL vs CentOS
  # 3.4.3 - Requires params from user
  # 3.6.2 - some firewall rules out of scope
  # 3.6.5 - some firewall rules out of scope
  # 4.2.1.4 - requires params from user
  #
  # 5.2.3 - PENDING: Works correctly, control/test is looking for Info instead of INFO. TODO: Remove when upstream profile is patched
  #
  # 5.2.15 - Requires params from user
  # 6.2.8 - control is picking up users like halt and sync which is causing failures when checking /sbin permissions
  skipped_controls = %w(
    xccdf_org.cisecurity.benchmarks_rule_1.1.8_Ensure_nodev_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.9_Ensure_nosuid_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.10_Ensure_noexec_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.14_Ensure_nodev_option_set_on_home_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.17_Ensure_noexec_option_set_on_devshm_partition

    xccdf_org.cisecurity.benchmarks_rule_1.2.1_Ensure_package_manager_repositories_are_configured
    xccdf_org.cisecurity.benchmarks_rule_1.2.3_Ensure_GPG_keys_are_configured
    xccdf_org.cisecurity.benchmarks_rule_1.2.4_Ensure_Red_Hat_Network_or_Subscription_Manager_connection_is_configured

    xccdf_org.cisecurity.benchmarks_rule_3.4.3_Ensure_etchosts.deny_is_configured

    xccdf_org.cisecurity.benchmarks_rule_3.6.2_Ensure_default_deny_firewall_policy
    xccdf_org.cisecurity.benchmarks_rule_3.6.5_Ensure_firewall_rules_exist_for_all_open_ports

    xccdf_org.cisecurity.benchmarks_rule_4.2.1.4_Ensure_rsyslog_is_configured_to_send_logs_to_a_remote_log_host
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.1_Ensure_syslog-ng_service_is_enabled
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.3_Ensure_syslog-ng_default_file_permissions_configured
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.4_Ensure_syslog-ng_is_configured_to_send_logs_to_a_remote_log_host

    xccdf_org.cisecurity.benchmarks_rule_5.2.3_Ensure_SSH_LogLevel_is_set_to_INFO

    xccdf_org.cisecurity.benchmarks_rule_5.2.15_Ensure_SSH_access_is_limited

    xccdf_org.cisecurity.benchmarks_rule_6.1.6_Ensure_permissions_on_etcpasswd-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.7_Ensure_permissions_on_etcshadow-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.8_Ensure_permissions_on_etcgroup-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.9_Ensure_permissions_on_etcgshadow-_are_configured

    xccdf_org.cisecurity.benchmarks_rule_6.2.8_Ensure_users_home_directories_permissions_are_750_or_more_restrictive
    xccdf_org.cisecurity.benchmarks_rule_6.2.9_Ensure_users_own_their_home_directories
    xccdf_org.cisecurity.benchmarks_rule_6.2.15_Ensure_all_groups_in_etcpasswd_exist_in_etcgroup
  )

  # TODO: Determine if user configuration is out of scope. If it is, keep these skipped. If not, add logic for user config
  # xccdf_org.cisecurity.benchmarks_rule_1.2.3_Ensure_GPG_keys_are_configured
  # xccdf_org.cisecurity.benchmarks_rule_3.4.3_Ensure_etchosts.deny_is_configured
  # xccdf_org.cisecurity.benchmarks_rule_5.2.15_Ensure_SSH_access_is_limited
  # xccdf_org.cisecurity.benchmarks_rule_6.2.15_Ensure_all_groups_in_etcpasswd_exist_in_etcgroup

  skipped_controls.each { |ctrl| skip_control ctrl }
end
