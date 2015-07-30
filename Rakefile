# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require './lib/red_alert'

require 'bundler'
require 'motion/project/template/gem/gem_tasks'
Bundler.require

require 'ruby_motion_query'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.identifier = 'com.gantlaborde.red_alert'
  app.name = 'RedAlert'
  app.deployment_target = ENV["DEPLOYMENT_TARGET"] if ENV["DEPLOYMENT_TARGET"]
  app.device_family = [:iphone, :ipad]
end
