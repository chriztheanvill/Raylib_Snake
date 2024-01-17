# Threads
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

set(THREAD_LIBRARIES
	Threads::Threads
	)
