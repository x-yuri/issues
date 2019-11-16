max_threads = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads = ENV.fetch('RAILS_MIN_THREADS') { max_threads }
threads min_threads, max_threads

n_workers = ENV.fetch('PUMA_N_WORKERS') { 0 }
workers n_workers
if n_workers.to_i > 0
  preload_app!
end

plugin :tmp_restart
