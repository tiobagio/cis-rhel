include_controls 'cis-rhel6-level1-server' do
  # RHEL 6 controls that are out of scope for remediation
  #
  skipped_controls = %w(
    xccdf_org.cisecurity.benchmarks_rule_1.1.8_Ensure_nodev_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.9_Ensure_nosuid_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.10_Ensure_noexec_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.14_Ensure_nodev_option_set_on_home_partition

    xccdf_org.cisecurity.benchmarks_rule_1.1.15_Ensure_nodev_option_set_on_devshm_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.16_Ensure_nosuid_option_set_on_devshm_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.17_Ensure_noexec_option_set_on_devshm_partition

    xccdf_org.cisecurity.benchmarks_rule_1.4.2_Ensure_bootloader_password_is_set

    xccdf_org.cisecurity.benchmarks_rule_3.4.3_Ensure_etchosts.deny_is_configured

    xccdf_org.cisecurity.benchmarks_rule_3.6.2_Ensure_default_deny_firewall_policy
    xccdf_org.cisecurity.benchmarks_rule_3.6.5_Ensure_firewall_rules_exist_for_all_open_ports

    xccdf_org.cisecurity.benchmarks_rule_4.2.1.4_Ensure_rsyslog_is_configured_to_send_logs_to_a_remote_log_host

    xccdf_org.cisecurity.benchmarks_rule_5.2.15_Ensure_SSH_access_is_limited

    xccdf_org.cisecurity.benchmarks_rule_6.1.6_Ensure_permissions_on_etcpasswd-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.8_Ensure_permissions_on_etcgroup-_are_configured

    xccdf_org.cisecurity.benchmarks_rule_6.2.9_Ensure_users_own_their_home_directories
  )

  # xccdf_org.cisecurity.benchmarks_rule_5.3.1_Ensure_password_creation_requirements_are_configured
  # 5.3.1 is failing with a possible matcher issue:
  # ×  -1 should cmp <= -1
  # expected it to be <= -1
  # got: -1
  # (compared using `cmp` matcher)

  skipped_controls.each { |ctrl| skip_control ctrl }
end
