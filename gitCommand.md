# 获得版本库
git init 初始化版本库
git clone 把远程仓库克隆到本地，并生成本地版本库

# 版本管理
git add 把版本库中已修改的文件添加进暂存区中git commit 把暂存区的文件添加进版本库中

## 删除 
  ### git rm 删除
  #### 执行两步操作:
    * 1.执行删除操作
    * 2.将删除的文件纳入暂存区
  ### rm
  #### 执行一步操作:
    * 1.只执行删除操作，不纳入暂存区

## 移动或重命名
   ### git mv
   #### 执行两步操作:
    * 1.执行重命名操作
    * 2.将重命名的文件纳入暂存区
  
  ### mv
  #### 执行一步操作:
    * 1.只执行重命名名操作，不纳入暂存区

## git commit --amend -m '需要修正的消息' 
  修正提交了的错误消息

# 版本回退 git reset --hard 
   * git reset --hard HEAD^   回退到上个版本
   * git reset --hard HEAD~2  回退到第几个版本
   * git reset --hard commit id  回退到指定id版本
   ## 查看commit id
   * git reflog

# 保存工作区    
 如果临时有事需要切换到别的分支，但本分支上的工作还未完成，可以使用git stash 命令将未完成的工作临时保存起来，在将来的某个时候可以再将它释放出来继续工作
 * git stash                 保存工作区
 * git stash list            列出保存列表
* git stash pop             弹出工作区并删除该id
* git stash apply           恢复到工作区
* git stash apply list id   恢复到指定工作区



# 分支管理:一条commit对象链，一条工作记录线
* git branch                   查看全部的分支
* git branch 分支名称          创建新分支
* git branch -m 分支名 另一分支名 分支重命名
* git checkout 分支名称        切换到该分支
* git checkout commit id       切换到该提交
* git checkout -b 分支名称     创建并切换到该分支
* git branch -d 分支名称       删除该分支
* git marge 分支名称           合并该分支
   将该分支合并到当前处于的分支

  ##  HEAD: 指向当前分支
   ## 分支: 指向的提交

  ## 分支合并: git merge [--no-ff] 分支名称 
     参数:--no-ff 表示禁用fast-forward
     这时在git提交中会多出一条commit id，如果删除分支就会把分支上的信息保留下来
   * fast-forword 快进
      一个分支上有修改，另一个分支上没有修改，将没有修改的分支合并到有修改的分支，就叫快进，没有修改的分支直接跳转到最新的提交。
   * conflict 冲突
      一个分支上的文件有修改，另一个分支上的同一个文件也有修改，合并时就会出现冲突，需要手动的去修改该冲突，保留一个修改，然后进行提交,再合并时，就不会有冲突了



# 查看信息
* git help 获取帮助

## git log [--gragh] 查看日志 
  参数:--gragh 表示以图形化界面查看
  还可以以某种格式去定制查看日志

## git diff 比较文件
  * git diff                     比较暂存区和工作区的区别
  * git diff commit id           比较版本库和工作区的区别
  * git diff --cached commit id  比较版本库和暂存区的区别
  * git diff commit id commit id 比较两个版本库的区别
  

# 远程协作
##标签
* git tag 标签名                  添加标签
* git tag 标签名 -m 标签说明      添加标签及说明
* git tag                         查看标签
* git tag -d 标签名               删除标签


## git pull 拉取文件
## git push 推送文件


