#
# Create report of failed results only
#

require 'json'
require 'fileutils'

FileUtils.mkdir_p 'tmp'

report = JSON.parse(File.read('tmp/results-min.json'))
report['controls'].delete_if { |x| x['status'] != 'failed' }

File.open('tmp/results-failed-min.json', 'w') do |f|
  f.write(JSON.pretty_generate(report))
end
