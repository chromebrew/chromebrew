#!/usr/bin/env ruby

require 'package'
class Uninstall < Package
  description 'Remove crew and all of its components'
  homepage 'https://skycocker.github.io/chromebrew'
  version '0.4.3'
  source_url 'https://github.com/skycocker/chromebrew/raw/master/lib/blank'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.install
    system "crew list installed | sed '/ruby/d' | tr '\n' ' ' > #{CREW_PREFIX}/tmp/installed.vGGdhY"
    system "printf 'crew remove ' > #{CREW_PREFIX}/tmp/remove.vGGdhY"
    system "printf '\#!/bin/bash'\"\n\" > #{CREW_PREFIX}/tmp/header.vGGdhY"
    system "cat", "#{CREW_PREFIX}/tmp/header.vGGdhY",
                  "#{CREW_PREFIX}/tmp/remove.vGGdhY",
                  "#{CREW_PREFIX}/tmp/installed.vGGdhY",
                  "> #{CREW_PREFIX}/tmp/uninstall.vGGdhY"
    system "chmod a+rwx #{CREW_PREFIX}/tmp/uninstall.vGGdhY"
    system "#{CREW_PREFIX}/tmp/uninstall.vGGdhY"
    system "rm -rf #{CREW_BREW_DIR}",
    "#{CREW_CONFIG_PATH}",
    "#{CREW_BREW_DIR}",
    "#{CREW_PREFIX}/tmp/header.vGGdhY",
    "#{CREW_PREFIX}/tmp/remove.vGGdhY",
    "#{CREW_PREFIX}/tmp/installed.vGGdhY",
    "#{CREW_PREFIX}/tmp/uninstall.vGGdhY",
    "&& crew remove ruby",
    "&& rm -rf #{CREW_LIB_PATH} #{CREW_PREFIX}/bin/crew"
  end
