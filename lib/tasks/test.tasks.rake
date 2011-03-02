namespace :test do

  desc "Test helper source"
  Rake::TestTask.new(:helper) do |t|    
    t.libs << "test"
    t.pattern = 'test/helper/**/*_test.rb'
    t.verbose = true    
  end

end

lib_task = Rake::Task["test:helper"]
test_task = Rake::Task[:test]
test_task.enhance { lib_task.invoke }