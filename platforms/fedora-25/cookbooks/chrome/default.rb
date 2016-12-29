puts "Chrome"

remote_file "/etc/yum.repos.d/google-chrome.repo"
package "google-chrome-stable"
