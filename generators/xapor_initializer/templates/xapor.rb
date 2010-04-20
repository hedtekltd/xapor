Thread.new do
  Delayed::Worker.new.start
end