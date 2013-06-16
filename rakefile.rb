#task must be enclosed in do-end not in curly brackets -> {} !
desc 'first task'
task :first do
	puts 'This is my first task'
end

desc 'Prerequisite nr1'
task :preq1 do
	puts "I'm needed!"
end

desc 'Prerequisite nr2'
task :preq2 do
	puts "I'm needed too!"
end

desc 'Task that need preq1 and preq2'
task :need_preqs => ["preq1", "preq2"] do
	puts "I run every preqs"
end

desc 'It will run '
task :args_task, [:first_arg, :second_arg] => ["need_preqs"] do |t, args|
	args.with_defaults( first_arg: :hello, second_arg: :bye)
	puts "I run |need_preqs| task!"
	puts "and here I will show you that #{args.first_arg} is #{args.second_arg}"
end

task :default => ["first"] do
	puts "... and I'm called from 'deafault' task"
end

desc 'example task with invoke'
task :invoke_me, [:f, :s] do |t, args|
	puts 'some text before invocation'
	Rake::Task[:args_task].invoke args.f, args.s
	puts 'some text after invocation'
end

desc 'mydoc.xml'
file 'mydoc.xml'  do
  puts 'done xml'
end

desc 'mydoc.xslt'
file 'mydoc.xslt'do
  puts 'done xslt'
end
desc 'mydoc.pdf'
file 'mydoc.pdf' => ['mydoc.xml', 'mydoc.xslt'] do
  puts 'done'
end

desc 'create .lol directory'
directory ".lol"

my_files = FileList['build/*.html', 'index.xml']

require 'rake/clean'
CLEAN.include('*.xxx')
CLOBBER.include('h/*')

desc 'copy file \'copy_me.txt\' to build folder'
task :copy_file do
  cp('copy_me.txt', File.join('build','copy_me.txt'), :verbose => true)
end

desc 'move index2.txt to same place changing name to index.txt'
task :move_file do
  mv 'index2.txt', File.join('b','index.txt'), :verbose => true
end

desc 'taking enviroment variables'
task :var do
	puts ENV['HOME']
	puts ENV['GOROOT']
end

namespace 'build' do

	desc 'some task in "build" namespace'
	task :some_task do
		puts 'hello, I\'m task from `build` namespace'
	end
end

desc 'task using namespace\'s task'
task :nam_task do
	Rake::Task['build:some_task'].invoke
	puts 'done running task from ~~build~~ namespace'
end
