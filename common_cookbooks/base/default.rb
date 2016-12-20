%w(bin src tmp).each do |dir|
  directory dir do
    user username
  end
end
