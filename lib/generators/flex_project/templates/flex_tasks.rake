#!/usr/bin/env ruby
FLEX_PROJECT="<%= flex_name %>"
FLEX_SRC="flex/src"
FLEX_BIN="flex/bin"
FLEX_LIB="flex/lib"
FLEX_MAIN_FILE = "<%= "#{file_name}.mxml" %>"
FLEX_OUTPUT_FILE = "#{FLEX_PROJECT}.swf"

namespace :flex do
  desc "Build Flex application"
  task :build do
    puts "Compilling #{FLEX_PROJECT}"
    command = "mxmlc #{FLEX_SRC}/#{FLEX_MAIN_FILE} -sp #{FLEX_SRC} -library-path+=#{FLEX_LIB} -o #{FLEX_BIN}/#{FLEX_OUTPUT_FILE}"
    sh command
  end

  desc "Run Flex application"
  task :run => :build do
    command = "flashplayer #{FLEX_BIN}/#{FLEX_OUTPUT_FILE}"
    sh command
  end

  desc "Run Flex application in debuger"
  task :debug => :build do
    command = "fdb #{FLEX_BIN}/#{FLEX_OUTPUT_FILE}"
    sh command
  end

  desc "Clean Flex Build directory"
  task :clean do
    rm_rf "#{FLEX_BIN}/#{FLEX_OUTPUT_FILE}"
    rmdir FLEX_BIN
  end

  desc "Copy Flex application into public rails folder"
  task :deploy => :build do
    cp "#{FLEX_BIN}/#{FLEX_OUTPUT_FILE}", "public/#{FLEX_OUTPUT_FILE}"
  end
end