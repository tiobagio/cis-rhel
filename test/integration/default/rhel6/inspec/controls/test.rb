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

    xccdf_org.cisecurity.benchmarks_rule_4.2.1.4_Ensure_rsyslog_is_configured_to_send_logs_to_a_remote_log_host

    xccdf_org.cisecurity.benchmarks_rule_6.1.6_Ensure_permissions_on_etcpasswd-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.8_Ensure_permissions_on_etcgroup-_are_configured

    xccdf_org.cisecurity.benchmarks_rule_6.2.9_Ensure_users_own_their_home_directories
  )

  skipped_controls.each { |ctrl| skip_control ctrl }
end
