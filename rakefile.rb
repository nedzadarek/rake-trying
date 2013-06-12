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