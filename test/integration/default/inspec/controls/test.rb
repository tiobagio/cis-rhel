include_controls 'cis-rhel7-level1-server' do
  # RHEL 7 controls that are out of scope for remediation
  # skipped_controls = %w(
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.5_Create_Separate_Partition_for_var
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.6_Bind_Mount_the_vartmp_directory_to_tmp
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.7_Create_Separate_Partition_for_varlog
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.8_Create_Separate_Partition_for_varlogaudit
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.10_Add_nodev_Option_to_home
  #   xccdf_org.cisecurity.benchmarks_rule_1.1.16_Add_noexec_Option_to_devshm_Partition
  #
  #   xccdf_org.cisecurity.benchmarks_rule_1.2.1_Ensure_package_manager_repositories_are_configured
  #
  #   xccdf_org.cisecurity.benchmarks_rule_1.5.3_Set_Boot_Loader_Password
  #
  #   xccdf_org.cisecurity.benchmarks_rule_7.1.1_Set_Password_Expiration_Days
  #
  #   xccdf_org.cisecurity.benchmarks_rule_9.2.1_Ensure_Password_Fields_are_Not_Empty
  #   xccdf_org.cisecurity.benchmarks_rule_9.2.12_Check_That_Users_Are_Assigned_Valid_Home_Directories
  # )
  #
  # skipped_controls.each { |ctrl| skip_control ctrl }
end
