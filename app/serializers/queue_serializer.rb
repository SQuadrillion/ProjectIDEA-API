class QueueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :url, :time, :name
end
