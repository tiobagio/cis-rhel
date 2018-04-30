#
# AWS RHEL 7 Integration Tests and skipped controls
#

include_controls 'cis-rhel7-level1-server' do
  # CIS-RHEL7 v2.2.0 controls that are out of scope for remediation
  #
  # - managing /var is out of scope
  # - syslog-ng requires RH subscription management
  #
  skipped_controls = %w(
    xccdf_org.cisecurity.benchmarks_rule_1.1.8_Ensure_nodev_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.9_Ensure_nosuid_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.10_Ensure_noexec_option_set_on_vartmp_partition
    xccdf_org.cisecurity.benchmarks_rule_1.1.14_Ensure_nodev_option_set_on_home_partition

    xccdf_org.cisecurity.benchmarks_rule_4.2.2.1_Ensure_syslog-ng_service_is_enabled
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.3_Ensure_syslog-ng_default_file_permissions_configured
    xccdf_org.cisecurity.benchmarks_rule_4.2.2.4_Ensure_syslog-ng_is_configured_to_send_logs_to_a_remote_log_host
  )

  skipped_controls.each { |ctrl| skip_control ctrl }
end
