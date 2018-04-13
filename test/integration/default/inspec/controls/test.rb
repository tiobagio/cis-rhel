include_controls 'cis-centos7-level1' do
  # CentOS 7 controls that are out of scope for remediation
  skipped_controls = %w(
    xccdf_org.cisecurity.benchmarks_rule_1.1.5_Create_Separate_Partition_for_var
    xccdf_org.cisecurity.benchmarks_rule_1.1.6_Bind_Mount_the_vartmp_directory_to_tmp
    xccdf_org.cisecurity.benchmarks_rule_1.1.7_Create_Separate_Partition_for_varlog
    xccdf_org.cisecurity.benchmarks_rule_1.1.8_Create_Separate_Partition_for_varlogaudit
    xccdf_org.cisecurity.benchmarks_rule_1.1.10_Add_nodev_Option_to_home
  )

  skipped_controls.each { |ctrl| skip_control ctrl }
end
