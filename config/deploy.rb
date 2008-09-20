set :application, "fbtest"
set :repository,  "svn://localhost/home/zhtao/mycode/fbtest/repo"
set :user, "tzhangco"
set :domain, "tzhang.com"
set :scm_command, "/home/username/bin/svn"
set :local_scm_command, :default

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/tzhangco/public_html/#{application}"
set :deploy_via, :copy
set :repository_is_not_reachable_from_remote, true
set :copy_strategy, :export

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true


# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

# This overwrites the original task for our purposes
desc <<-DESC
A macro-task that updates the code, fixes the symlink, added the symlink
to the shared uploads folder. Finally takes a snapshot of the db.
DESC
deploy.task :default do
  transaction do
    update_code
    symlink
  end
end
