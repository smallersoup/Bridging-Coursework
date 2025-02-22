# Bridging-Coursework

This bridging-coursework for 2019/20 at UoB

# Python django Blog

项目来源：

https://github.com/Ariescoco/Bridging-Coursework

fork 到：
https://github.com/smallersoup/Bridging-Coursework

python 版本：

```shell
$ python -V
Python 3.8.8
```

```shell
# 安装依赖
python -m pip install django
python -m pip install markdown

# 查看 django、markdown 版本
$ python -m django --version
4.1.4
$ python -m markdown --version
__main__.py 3.4.1
```

```shell
# 初始化 sqlite 数据，建表
python manage.py migrate
# 启动
python manage.py runserver
```

其他可操作命令：

```shell
python manage.py createcachetable
# 连接 sqlite 数据库
python manage.py dbshell
python manage.py inspectdb
```

运行之后的效果：
![](https://files.mdnice.com/user/23818/cfcec727-4438-4620-ab3b-9b48ef8f6c06.png)

```shell
$ python manage.py dbshell
SQLite version 3.35.4 2021-04-02 15:20:15
Enter ".help" for usage hints.
sqlite> .tables
auth_group                  blog_post
auth_group_permissions      blog_skills
auth_permission             blog_voluneering
auth_user                   blog_work
auth_user_groups            django_admin_log
auth_user_user_permissions  django_content_type
blog_comment                django_migrations
blog_education              django_session
blog_info
```

用工具打开 sqlite db 文件查看：
![](https://files.mdnice.com/user/23818/8a2314be-03fa-4f4d-bb58-e1c02b0859a5.png)

创建管理员用户：

```shell
$ python manage.py createsuperuser --username kubeinfo --email kubeinfo@qq.com
System check identified some issues:

WARNINGS:
blog.Comment: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.Post: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.education: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.info: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.skills: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.voluneering: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
blog.work: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'.
	HINT: Configure the DEFAULT_AUTO_FIELD setting or the BlogConfig.default_auto_field attribute to point to a subclass of AutoField, e.g. 'django.db.models.BigAutoField'.
Password:
```

创建时，输入密码后回车没反应，可能是 WARNINGS 警告导致的。

参考文档：[Error: blog.Comment: (models.W042) Auto-created primary key used when not defining a primary key type, by default 'django.db.models.AutoField'](https://stackoverflow.com/questions/70904550/error-blog-comment-models-w042-auto-created-primary-key-used-when-not-defini)

从[自动创建的主键 \[Django Doc\]](https://docs.djangoproject.com/en/3.2/releases/3.2/#customizing-type-of-auto-created-primary-keys)

> 为避免将来发生不必要的迁移，请将 DEFAULT_AUTO_FIELD 显式设置为 AutoField

添加`DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'`你的`settings.py`

> 如果您想设置每个应用程序的字段类型，那么您可以指定每个应用程序的基础

```python
from django.apps import AppConfig

class MyAppConfig(AppConfig):
    default_auto_field = 'django.db.models.AutoField'
    name = 'my_app'
```

> 甚至您可以将每个模型的基础指定为

```python
from django.db import models

class MyModel(models.Model):
    id = models.AutoField(primary_key=True)
```

添加`DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'`到`settings.py`中：
![](https://files.mdnice.com/user/23818/47d24b8c-f3ea-4e9f-b8c0-2f504b0c618e.png)

此时不报错了，但是回车还是没反应。

参考这篇文章不用交互式创建：https://stackoverflow.com/questions/32532900/not-able-to-create-super-user-with-django-manage-py

**从[Django 3.0](https://docs.djangoproject.com/en/3.0/ref/django-admin/#django-admin-createsuperuser)开始，您可以通过两种方式创建没有 TTY 的超级用户**

**方式 1**：在命令行中将值和机密作为 ENV 传递

```shell
$ DJANGO_SUPERUSER_USERNAME=admin DJANGO_SUPERUSER_PASSWORD=test \
python manage.py createsuperuser --email=admin@admin.com --noinput

Superuser created successfully.
```

**方法二**：设置 DJANGO_SUPERUSER_PASSWORD 为环境变量

```shell
# .admin.env
DJANGO_SUPERUSER_PASSWORD=psw

# bash
source '.admin.env' && python manage.py createsuperuser --username=admin --email=admin@admin.com --noinput
```

此时可以看到 auth_user 表中有一条用户数据：

![](https://files.mdnice.com/user/23818/c7ab04be-bba6-4eac-a5f7-21f5629d8f87.png)

此时就可以用 admin 用登录：

![](https://files.mdnice.com/user/23818/79f02ac1-0a9c-4499-8a24-b27b706eacd9.png)

此时就可以新增文档，支持 markdown。

## Test

To run the functional test: ```python functional_tests.py```.

To run the unit test test: ```python manage.py test```.