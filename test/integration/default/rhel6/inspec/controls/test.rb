include_controls 'cis-rhel6-level1-server' do
  # RHEL 6 controls that are out of scope for remediation
  #
  skipped_controls = %w(

  )

  skipped_controls.each { |ctrl| skip_control ctrl }
end
