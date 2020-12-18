using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace ConexaoVagasAPI.Domains
{
    public partial class ConexaoVagasContext : DbContext
    {
        public ConexaoVagasContext()
        {
        }

        public ConexaoVagasContext(DbContextOptions<ConexaoVagasContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Administrador> Administrador { get; set; }
        public virtual DbSet<Beneficio> Beneficio { get; set; }
        public virtual DbSet<BeneficioVaga> BeneficioVaga { get; set; }
        public virtual DbSet<Candidato> Candidato { get; set; }
        public virtual DbSet<Candidatura> Candidatura { get; set; }
        public virtual DbSet<Empresa> Empresa { get; set; }
        public virtual DbSet<Endereco> Endereco { get; set; }
        public virtual DbSet<Habilidade> Habilidade { get; set; }
        public virtual DbSet<HabilidadeCandidato> HabilidadeCandidato { get; set; }
        public virtual DbSet<HabilidadeVaga> HabilidadeVaga { get; set; }
        public virtual DbSet<Matching> Matching { get; set; }
        public virtual DbSet<Notificacao> Notificacao { get; set; }
        public virtual DbSet<StatusUsuario> StatusUsuario { get; set; }
        public virtual DbSet<TipoUsuario> TipoUsuario { get; set; }
        public virtual DbSet<Usuario> Usuario { get; set; }
        public virtual DbSet<Vaga> Vaga { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();
                optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Administrador>(entity =>
            {
                entity.HasKey(e => e.IdUsuario);

                entity.Property(e => e.IdUsuario).ValueGeneratedNever();

                entity.HasOne(d => d.IdUsuarioNavigation)
                    .WithOne(p => p.Administrador)
                    .HasForeignKey<Administrador>(d => d.IdUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Administrador_Usuario");
            });

            modelBuilder.Entity<Beneficio>(entity =>
            {
                entity.HasKey(e => e.IdBeneficio);

                entity.HasIndex(e => e.NomeBeneficio)
                    .HasName("IX_Beneficio")
                    .IsUnique();

                entity.Property(e => e.NomeBeneficio)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdCriadoPorNavigation)
                    .WithMany(p => p.Beneficio)
                    .HasForeignKey(d => d.IdCriadoPor)
                    .HasConstraintName("FK_Beneficio_Usuario");
            });

            modelBuilder.Entity<BeneficioVaga>(entity =>
            {
                entity.HasKey(e => e.IdBeneficioVaga);

                entity.HasOne(d => d.IdBeneficioNavigation)
                    .WithMany(p => p.BeneficioVaga)
                    .HasForeignKey(d => d.IdBeneficio)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BeneficioVaga_Beneficio");

                entity.HasOne(d => d.IdVagaNavigation)
                    .WithMany(p => p.BeneficioVaga)
                    .HasForeignKey(d => d.IdVaga)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BeneficioVaga_Vaga");
            });

            modelBuilder.Entity<Candidato>(entity =>
            {
                entity.HasKey(e => e.IdUsuario);

                entity.HasIndex(e => e.Cpf)
                    .HasName("UQ_CPF")
                    .IsUnique();

                entity.HasIndex(e => e.Matricula)
                    .HasName("UQ_Matricula")
                    .IsUnique();

                entity.HasIndex(e => e.Rg)
                    .HasName("UQ_Rg")
                    .IsUnique();

                entity.Property(e => e.IdUsuario).ValueGeneratedNever();

                entity.Property(e => e.CelularCandidato)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Cpf)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Curso)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.DataNascimento).HasColumnType("date");

                entity.Property(e => e.FormacaoAcademica)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Matricula)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Nome)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Rg)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Sobrenome)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.TelefoneCandidato)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdEnderecoNavigation)
                    .WithMany(p => p.Candidato)
                    .HasForeignKey(d => d.IdEndereco)
                    .HasConstraintName("FK_Candidato_Endereco");

                entity.HasOne(d => d.IdStatusUsuarioNavigation)
                    .WithMany(p => p.Candidato)
                    .HasForeignKey(d => d.IdStatusUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Candidato_StatusUsuario");

                entity.HasOne(d => d.IdUsuarioNavigation)
                    .WithOne(p => p.Candidato)
                    .HasForeignKey<Candidato>(d => d.IdUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Candidato_Usuario");
            });

            modelBuilder.Entity<Candidatura>(entity =>
            {
                entity.HasKey(e => e.IdCandidatura);

                entity.Property(e => e.Curriculo)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.DataCriado).HasColumnType("datetime");

                entity.HasOne(d => d.IdCandidatoNavigation)
                    .WithMany(p => p.Candidatura)
                    .HasForeignKey(d => d.IdCandidato)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Candidatura_Candidato");

                entity.HasOne(d => d.IdVagaNavigation)
                    .WithMany(p => p.Candidatura)
                    .HasForeignKey(d => d.IdVaga)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Candidatura_Vaga");
            });

            modelBuilder.Entity<Empresa>(entity =>
            {
                entity.HasKey(e => e.IdUsuario);

                entity.HasIndex(e => e.Cnpj)
                    .HasName("UQ_Cnpj")
                    .IsUnique();

                entity.HasIndex(e => e.RazaoSocial)
                    .HasName("UQ_RazaoSocial");

                entity.Property(e => e.IdUsuario).ValueGeneratedNever();

                entity.Property(e => e.CelularEmpresa)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Cnae)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Cnpj)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Descricao)
                    .HasMaxLength(8000)
                    .IsUnicode(false);

                entity.Property(e => e.EmailPublico)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Foto)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.NomeFantasia)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.RazaoSocial)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.TelefoneEmpresa)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdEnderecoNavigation)
                    .WithMany(p => p.Empresa)
                    .HasForeignKey(d => d.IdEndereco)
                    .HasConstraintName("FK_Empresa_Endereco");

                entity.HasOne(d => d.IdStatusUsuarioNavigation)
                    .WithMany(p => p.Empresa)
                    .HasForeignKey(d => d.IdStatusUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Empresa_StatusUsuario");

                entity.HasOne(d => d.IdUsuarioNavigation)
                    .WithOne(p => p.Empresa)
                    .HasForeignKey<Empresa>(d => d.IdUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Empresa_Usuario");
            });

            modelBuilder.Entity<Endereco>(entity =>
            {
                entity.HasKey(e => e.IdEndereco);

                entity.Property(e => e.Cep)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.LocalCompleto)
                    .IsRequired()
                    .HasMaxLength(8000)
                    .IsUnicode(false);

                entity.Property(e => e.Uf)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Habilidade>(entity =>
            {
                entity.HasKey(e => e.IdHabilidade);

                entity.HasIndex(e => e.NomeHabilidade)
                    .HasName("UQ__Habilida__206452FF4DEB5434")
                    .IsUnique();

                entity.Property(e => e.NomeHabilidade)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdCriadoPorNavigation)
                    .WithMany(p => p.Habilidade)
                    .HasForeignKey(d => d.IdCriadoPor)
                    .HasConstraintName("FK_Habilidade_Usuario");
            });

            modelBuilder.Entity<HabilidadeCandidato>(entity =>
            {
                entity.HasKey(e => e.IdHabilidadeCandidato);

                entity.HasOne(d => d.IdCandidatoNavigation)
                    .WithMany(p => p.HabilidadeCandidato)
                    .HasForeignKey(d => d.IdCandidato)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HabilidadeCandidato_Candidato");

                entity.HasOne(d => d.IdHabilidadeNavigation)
                    .WithMany(p => p.HabilidadeCandidato)
                    .HasForeignKey(d => d.IdHabilidade)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HabilidadeCandidato_Habilidade");
            });

            modelBuilder.Entity<HabilidadeVaga>(entity =>
            {
                entity.HasKey(e => e.IdHabilidadeVaga);

                entity.HasOne(d => d.IdHabilidadeNavigation)
                    .WithMany(p => p.HabilidadeVaga)
                    .HasForeignKey(d => d.IdHabilidade)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HabilidadeVaga_Habilidade");

                entity.HasOne(d => d.IdVagaNavigation)
                    .WithMany(p => p.HabilidadeVaga)
                    .HasForeignKey(d => d.IdVaga)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HabilidadeVaga_Vaga");
            });

            modelBuilder.Entity<Matching>(entity =>
            {
                entity.HasKey(e => e.IdMatching);

                entity.Property(e => e.IdCandidato).HasColumnName("idCandidato");

                entity.HasOne(d => d.IdCandidatoNavigation)
                    .WithMany(p => p.Matching)
                    .HasForeignKey(d => d.IdCandidato)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Matching_Candidato");

                entity.HasOne(d => d.IdVagaNavigation)
                    .WithMany(p => p.Matching)
                    .HasForeignKey(d => d.IdVaga)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Matching_Vaga");
            });

            modelBuilder.Entity<Notificacao>(entity =>
            {
                entity.HasKey(e => e.IdNotificacao);

                entity.Property(e => e.DataNotificacao).HasColumnType("datetime");

                entity.Property(e => e.Mensagem)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<StatusUsuario>(entity =>
            {
                entity.HasKey(e => e.IdStatusUsuario);

                entity.Property(e => e.NomeStatus)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TipoUsuario>(entity =>
            {
                entity.HasKey(e => e.IdTipoUsuario);

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.HasKey(e => e.IdUsuario);

                entity.HasIndex(e => e.Email)
                    .HasName("UQ_Email")
                    .IsUnique();

                entity.Property(e => e.DataCadastrado).HasColumnType("datetime");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Senha)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdTipoUsuarioNavigation)
                    .WithMany(p => p.Usuario)
                    .HasForeignKey(d => d.IdTipoUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Usuario_TipoUsuario");
            });

            modelBuilder.Entity<Vaga>(entity =>
            {
                entity.HasKey(e => e.IdVaga);

                entity.Property(e => e.DataCriado).HasColumnType("datetime");

                entity.Property(e => e.DataExpiracao).HasColumnType("datetime");

                entity.Property(e => e.Descricao)
                    .IsRequired()
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.Qualificacao)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Salario).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.Titulo)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdEmpresaNavigation)
                    .WithMany(p => p.Vaga)
                    .HasForeignKey(d => d.IdEmpresa)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Vaga_Empresa");

                entity.HasOne(d => d.IdEnderecoNavigation)
                    .WithMany(p => p.Vaga)
                    .HasForeignKey(d => d.IdEndereco)
                    .HasConstraintName("FK_Vaga_Endereco");
            });
        }
    }
}
