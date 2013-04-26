# python_version.rb

Facter.add("python_version") do
  setcode do
    Facter::Util::Resolution.exec('/usr/bin/python -c "import sys; print \"%s.%s\" %(sys.version_info[0],sys.version_info[1])"')
  end
end
