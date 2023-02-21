using Blog.Models;
using Blog.Repositores;
using Dapper;
using Dapper.Contrib.Extensions;
using Microsoft.Data.SqlClient;

namespace Blog
{
    class Program
    {
        private const string CONNECTION_STRING = @"Server=localhost,1433;Database=Blog;User ID=sa;Password=(insira a senha);TrustServerCertificate=True";
        static void Main(string[] args)
        {
            var connection = new SqlConnection(CONNECTION_STRING);
            connection.Open();

            //ReadUsers(connection);
            //ReadRoles(connection);
            //ReadTags(connection);
            //CreateUser(connection);
            //ReadUsersWithRoles(connection);
            
            connection.Close();
        }

        

        public static void CreateUser(SqlConnection connection)
        {
            var user = new User()
            {
                Email = "email@gmail.com",
                Bio = "bio",
                Image = "image",
                Name = "name",
                PasswordHash = Guid.NewGuid().ToString(),
                Slug = "slug"
            };
            var repository = new Repository<User>(connection);
            repository.Create(user);
        }

        public static void ReadUsers(Repository<User> repository)
        {
            var users = repository.Get();
            foreach (var item in users)
            {
                Console.WriteLine(item.Name);
            }
        }

        public static void ReadUser(Repository<User> repository)
        {
            var user = repository.Get(2);
            Console.WriteLine(user.Name);
        }

        public static void UpdateUser(Repository<User> repository)
        {
            var user = repository.Get(2);
            user.Email = "hello@gmail.com";
            repository.Update(user);

            Console.WriteLine(user?.Email);
        }

        public static void Delete(Repository<User> repository)
        {
            var user = repository.Get(2);
            repository.Delete(user);
        }

        public static void ReadRoles(SqlConnection connection)
        {
            var repository = new Repository<Role>(connection);
            var items = repository.Get();

            foreach (var item in items)
                Console.WriteLine(item.Name);
        }

        public static void ReadTags(SqlConnection connection)
        {
            var repository = new Repository<Tag>(connection);
            var items = repository.Get();

            foreach (var item in items)
                Console.WriteLine(item.Name);
        }

        public static void ReadUsersWithRoles(SqlConnection connection)
        {
            var repository = new UserRepository(connection);
            var items = repository.GetWithRoles();

            foreach (var item in items)
            {
                Console.WriteLine(item.Name);
                foreach (var role in item.Roles)
                {
                    Console.WriteLine($" - {role.Name}");
                }
            }

        }

    }
}