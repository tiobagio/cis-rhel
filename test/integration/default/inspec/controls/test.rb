include_controls 'cis-rhel7-level1-server' do
  # RHEL 7 controls that are out of scope for remediation
  #
  # 1.2.1 - skipping for now until we add logic RHEL vs Cent
  # 6.2.8 - control is picking up users like halt and sync which is causing failures when checking /sbin permissions
  skipped_controls = %w(
    xccdf_org.cisecurity.benchmarks_rule_1.1.8_Ensure_nodev_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.9_Ensure_nosuid_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.10_Ensure_noexec_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.14_Ensure_nodev_option_set_on_home_partition

    xccdf_org.cisecurity.benchmarks_rule_1.2.1_Ensure_package_manager_repositories_are_configured

    xccdf_org.cisecurity.benchmarks_rule_4.2.2.1_Ensure_syslog-ng_service_is_enabled
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.3_Ensure_syslog-ng_default_file_permissions_configured
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.4_Ensure_syslog-ng_is_configured_to_send_logs_to_a_remote_log_host

    xccdf_org.cisecurity.benchmarks_rule_6.1.6_Ensure_permissions_on_etcpasswd-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.7_Ensure_permissions_on_etcshadow-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.8_Ensure_permissions_on_etcgroup-_are_configured
    xccdf_org.cisecurity.benchmarks_rule_6.1.9_Ensure_permissions_on_etcgshadow-_are_configured

    xccdf_org.cisecurity.benchmarks_rule_6.2.8_Ensure_users_home_directories_permissions_are_750_or_more_restrictive
  )
  # TODO: Update these from Cent to RHEL, then add to skip
  # xccdf_org.cisecurity.benchmarks_rule_1.5.3_Set_Boot_Loader_Password
  #
  # xccdf_org.cisecurity.benchmarks_rule_7.1.1_Set_Password_Expiration_Days
  #
  # xccdf_org.cisecurity.benchmarks_rule_9.2.1_Ensure_Password_Fields_are_Not_Empty
  # xccdf_org.cisecurity.benchmarks_rule_9.2.12_Check_That_Users_Are_Assigned_Valid_Home_Directories

  skipped_controls.each { |ctrl| skip_control ctrl }
end
