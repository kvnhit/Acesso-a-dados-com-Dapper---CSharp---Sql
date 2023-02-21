create table [Role](
    [Id] int not null IDENTITY(1, 1),
    [Name] VARCHAR(80) not null,
    [Slug] varchar(20) not null,

    CONSTRAINT [PK_Role] primary key([Id]),
    CONSTRAINT [UQ_Role_Slug] unique ([Slug]),
)

create NONCLUSTERED INDEX [IX_Role_Slug] on [Role]([Slug])

create table[UserRole](
    [UserId] int not null,
    [RoleId] int not null,

    constraint [PK_UserRole] PRIMARY key([UserId], [RoleId])
)

create table [Category](
    [Id] int not null IDENTITY(1, 1),
    [Name] VARCHAR(80) not null,
    [Slug] varchar(80) not null,

    CONSTRAINT [PK_Category] primary key([Id]),
    CONSTRAINT [UQ_Category_Slug] unique ([Slug]),
)

create NONCLUSTERED INDEX [IX_Category_Slug] on [Category]([Slug])

create table [Post](
    [Id] int not null IDENTITY(1, 1),
    [CategoryId] int not null,
    [AuthorId] int not null,
    [Title] varchar(80) not null,
    [Summary] varchar(255) not null,
    [Body] text not null,
    [Slug] varchar(80) not null,
    [CreateDate] datetime not null default(GETDATE()),
    [LastUpdateDate] datetime not null default(GETDATE()),

    CONSTRAINT [PK_Post] PRIMARY KEY([Id]),
    CONSTRAINT [FK_Post_Category] FOREIGN KEY([CategoryId]) REFERENCES [Category]([Id]),
    CONSTRAINT [FK_Post_Author] FOREIGN KEY([AuthorId]) REFERENCES [User]([Id]),
    CONSTRAINT [UQ_Post_Slug] UNIQUE([Slug])
)
CREATE NONCLUSTERED INDEX [IX_Post_Slug] on [Post]([Slug])

create table [Tag](
    [Id] int not null IDENTITY(1, 1),
    [Name] VARCHAR(80) not null,
    [Slug] varchar(80) not null,

    CONSTRAINT [PK_Tag] primary key([Id]),
    CONSTRAINT [UQ_Tag_Slug] unique ([Slug]),
)

create NONCLUSTERED INDEX [IX_Tag_Slug] on [Tag]([Slug])

create table [PostTag](
    [PostId] int not null,
    [TagId] int not null,

    CONSTRAINT [PK_PostTag] primary key([PostId], [TagId]),
)

create table [User](
    [Id] int not null IDENTITY(1, 1),
    [Name] NVARCHAR(80) not null,
    [Email] varchar(200) not null,
    [PasswordHash] varchar(255) not null,
    [Bio] text not null, 
    [Image] varchar(2000) not null,
    [Slug] varchar(20) not null,

    CONSTRAINT [PK_User] primary key([Id]),
    CONSTRAINT [UQ_User_Email] unique ([Email]),
    CONSTRAINT [UQ_User_Slug] unique ([Slug])
)

create NONCLUSTERED INDEX [IX_User_Email] on [User]([Email])
create NONCLUSTERED INDEX [IX_User_SLug] on [User]([Slug])