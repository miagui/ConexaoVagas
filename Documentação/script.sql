USE [master]
GO
/****** Object:  Database [ConexaoVagas]    Script Date: 18/12/2020 16:08:25 ******/
CREATE DATABASE [ConexaoVagas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ConexaoVagas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ConexaoVagas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ConexaoVagas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ConexaoVagas_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ConexaoVagas] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ConexaoVagas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ConexaoVagas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ConexaoVagas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ConexaoVagas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ConexaoVagas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ConexaoVagas] SET ARITHABORT OFF 
GO
ALTER DATABASE [ConexaoVagas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ConexaoVagas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ConexaoVagas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ConexaoVagas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ConexaoVagas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ConexaoVagas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ConexaoVagas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ConexaoVagas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ConexaoVagas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ConexaoVagas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ConexaoVagas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ConexaoVagas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ConexaoVagas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ConexaoVagas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ConexaoVagas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ConexaoVagas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ConexaoVagas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ConexaoVagas] SET RECOVERY FULL 
GO
ALTER DATABASE [ConexaoVagas] SET  MULTI_USER 
GO
ALTER DATABASE [ConexaoVagas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ConexaoVagas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ConexaoVagas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ConexaoVagas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ConexaoVagas] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ConexaoVagas', N'ON'
GO
ALTER DATABASE [ConexaoVagas] SET QUERY_STORE = OFF
GO
USE [ConexaoVagas]
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrador](
	[IdUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Administrador] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Beneficio]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficio](
	[IdBeneficio] [int] IDENTITY(1,1) NOT NULL,
	[IdCriadoPor] [int] NULL,
	[NomeBeneficio] [varchar](255) NOT NULL,
 CONSTRAINT [PK__Benefici__14B7CA0C4D6B1A08] PRIMARY KEY CLUSTERED 
(
	[IdBeneficio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BeneficioVaga]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BeneficioVaga](
	[IdBeneficioVaga] [int] IDENTITY(1,1) NOT NULL,
	[IdBeneficio] [int] NOT NULL,
	[IdVaga] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdBeneficioVaga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Candidato]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidato](
	[IdUsuario] [int] NOT NULL,
	[IdStatusUsuario] [int] NOT NULL,
	[IdEndereco] [int] NULL,
	[Nome] [varchar](255) NULL,
	[Sobrenome] [varchar](255) NULL,
	[Curso] [varchar](255) NULL,
	[FormacaoAcademica] [varchar](255) NULL,
	[Matricula] [varchar](255) NOT NULL,
	[Cpf] [varchar](255) NOT NULL,
	[Rg] [varchar](255) NOT NULL,
	[TelefoneCandidato] [varchar](255) NULL,
	[CelularCandidato] [varchar](255) NULL,
	[DataNascimento] [date] NOT NULL,
	[Visualizacao] [int] NOT NULL,
 CONSTRAINT [PK__Candidat__D5598905F1707E7E] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Candidatura]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidatura](
	[IdCandidatura] [int] IDENTITY(1,1) NOT NULL,
	[IdCandidato] [int] NOT NULL,
	[IdVaga] [int] NOT NULL,
	[Curriculo] [varchar](255) NULL,
	[Visualizado] [bit] NOT NULL,
	[DataCriado] [datetime] NOT NULL,
 CONSTRAINT [PK__Candidat__7B9E9EACAE85B9C4] PRIMARY KEY CLUSTERED 
(
	[IdCandidatura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[IdUsuario] [int] NOT NULL,
	[IdStatusUsuario] [int] NOT NULL,
	[IdEndereco] [int] NULL,
	[Foto] [varchar](255) NULL,
	[Cnae] [varchar](255) NOT NULL,
	[Cnpj] [varchar](255) NOT NULL,
	[RazaoSocial] [varchar](255) NOT NULL,
	[NomeFantasia] [varchar](255) NULL,
	[EmailPublico] [varchar](255) NULL,
	[Descricao] [varchar](8000) NULL,
	[TelefoneEmpresa] [varchar](255) NULL,
	[CelularEmpresa] [varchar](255) NULL,
	[Visualizacao] [int] NOT NULL,
 CONSTRAINT [PK__Empresa__5EF4033EBB5814A4] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Endereco]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Endereco](
	[IdEndereco] [int] IDENTITY(1,1) NOT NULL,
	[Cep] [varchar](255) NOT NULL,
	[LocalCompleto] [varchar](8000) NOT NULL,
	[Uf] [varchar](255) NOT NULL,
	[Lat] [float] NOT NULL,
	[Long] [float] NOT NULL,
 CONSTRAINT [PK_Endereco] PRIMARY KEY CLUSTERED 
(
	[IdEndereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Habilidade]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habilidade](
	[IdHabilidade] [int] IDENTITY(1,1) NOT NULL,
	[IdCriadoPor] [int] NULL,
	[NomeHabilidade] [varchar](255) NOT NULL,
 CONSTRAINT [PK__Habilida__0DD4B30DBBE8726F] PRIMARY KEY CLUSTERED 
(
	[IdHabilidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabilidadeCandidato]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabilidadeCandidato](
	[IdHabilidadeCandidato] [int] IDENTITY(1,1) NOT NULL,
	[IdHabilidade] [int] NOT NULL,
	[IdCandidato] [int] NOT NULL,
 CONSTRAINT [PK__Habilida__F8880B5E9245D8D6] PRIMARY KEY CLUSTERED 
(
	[IdHabilidadeCandidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabilidadeVaga]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabilidadeVaga](
	[IdHabilidadeVaga] [int] IDENTITY(1,1) NOT NULL,
	[IdHabilidade] [int] NOT NULL,
	[IdVaga] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdHabilidadeVaga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matching]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matching](
	[IdMatching] [int] IDENTITY(1,1) NOT NULL,
	[IdVaga] [int] NOT NULL,
	[idCandidato] [int] NOT NULL,
	[Porcentagem] [float] NOT NULL,
	[Distancia] [float] NOT NULL,
 CONSTRAINT [PK_Matching] PRIMARY KEY CLUSTERED 
(
	[IdMatching] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacao]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificacao](
	[IdNotificacao] [int] IDENTITY(1,1) NOT NULL,
	[DataNotificacao] [datetime] NOT NULL,
	[Mensagem] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotificacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusUsuario]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusUsuario](
	[IdStatusUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NomeStatus] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStatusUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[IdTipoUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoUsuario] [int] NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Senha] [varchar](255) NOT NULL,
	[DataCadastrado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vaga]    Script Date: 18/12/2020 16:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vaga](
	[IdVaga] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdEndereco] [int] NULL,
	[Titulo] [varchar](255) NOT NULL,
	[Salario] [decimal](18, 0) NOT NULL,
	[Qualificacao] [varchar](255) NOT NULL,
	[DataCriado] [datetime] NOT NULL,
	[DataExpiracao] [datetime] NOT NULL,
	[CargaHoraria] [int] NOT NULL,
	[Descricao] [varchar](1000) NOT NULL,
	[Visualizacao] [int] NOT NULL,
 CONSTRAINT [PK__Vaga__A848DC3EC534346C] PRIMARY KEY CLUSTERED 
(
	[IdVaga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Administrador] ([IdUsuario]) VALUES (1053)
SET IDENTITY_INSERT [dbo].[Beneficio] ON 

INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (1, NULL, N'FGTS')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (2, NULL, N'Vale-Transporte')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (3, NULL, N'Férias')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (4, NULL, N'Décimo terceiro salário')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (5, NULL, N'Vale Alimentação')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (6, NULL, N'Vale Refeição')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (7, NULL, N'Refeitório no local de trabalho')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (8, NULL, N'Cesta Básica')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (9, NULL, N'Assistência médica')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (10, NULL, N'Vale Combustível')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (11, NULL, N'Vale automóvel')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (12, NULL, N'Vale-cultura')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (13, NULL, N'Home office e Horários flexíveis')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (14, NULL, N'Bolsas de estudo')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (15, NULL, N'Auxílio creche ou espaço para as crianças na empresa')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (16, NULL, N'Participação dos lucros (PLR)')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (17, NULL, N'Academias')
INSERT [dbo].[Beneficio] ([IdBeneficio], [IdCriadoPor], [NomeBeneficio]) VALUES (18, NULL, N'Convênio com estabelecimentos próximos ao local de trabalho')
SET IDENTITY_INSERT [dbo].[Beneficio] OFF
SET IDENTITY_INSERT [dbo].[BeneficioVaga] ON 

INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (26, 17, 26)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (29, 5, 28)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (30, 11, 28)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (31, 2, 29)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (32, 15, 29)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (35, 4, 31)
INSERT [dbo].[BeneficioVaga] ([IdBeneficioVaga], [IdBeneficio], [IdVaga]) VALUES (1049, 8, 1041)
SET IDENTITY_INSERT [dbo].[BeneficioVaga] OFF
INSERT [dbo].[Candidato] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Nome], [Sobrenome], [Curso], [FormacaoAcademica], [Matricula], [Cpf], [Rg], [TelefoneCandidato], [CelularCandidato], [DataNascimento], [Visualizacao]) VALUES (1049, 2, 1166, N'Matheus', N'Emorge', N'Desenvolvimento de Sistemas', N'Ensino Médio', N'15121105', N'051.859.728-57', N'12.548.460-9', N'(11) 9419-8226', N'(11) 98631-6715', CAST(N'2000-07-02' AS Date), 0)
INSERT [dbo].[Candidato] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Nome], [Sobrenome], [Curso], [FormacaoAcademica], [Matricula], [Cpf], [Rg], [TelefoneCandidato], [CelularCandidato], [DataNascimento], [Visualizacao]) VALUES (1075, 2, 56, N'Mariana Nascimento de Oliveira', NULL, N'Desenvolvimento De Sistemas', NULL, N'145789654', N'4457842748', N'2324785421', N'(11) 94637-6331', N'(11) 94637-6331', CAST(N'2005-06-17' AS Date), 0)
INSERT [dbo].[Candidato] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Nome], [Sobrenome], [Curso], [FormacaoAcademica], [Matricula], [Cpf], [Rg], [TelefoneCandidato], [CelularCandidato], [DataNascimento], [Visualizacao]) VALUES (2116, 2, 1134, N'marina souza', NULL, N'desenvolvimento de sistema', NULL, N'12345648', N'444.444.444-44', N'55.555.555-5', N'(11)5656-5656', N'(11)5654-5465', CAST(N'2000-10-03' AS Date), 0)
INSERT [dbo].[Candidato] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Nome], [Sobrenome], [Curso], [FormacaoAcademica], [Matricula], [Cpf], [Rg], [TelefoneCandidato], [CelularCandidato], [DataNascimento], [Visualizacao]) VALUES (2139, 2, 1164, N'Murilo Luiz Barbosa Gomes', NULL, N'redes', NULL, N'12312312', N'525.847.818-16', N'39.086.782-2', N'(11) 1111-1111', N'(11) 1111-1111', CAST(N'2003-12-31' AS Date), 0)
SET IDENTITY_INSERT [dbo].[Candidatura] ON 

INSERT [dbo].[Candidatura] ([IdCandidatura], [IdCandidato], [IdVaga], [Curriculo], [Visualizado], [DataCriado]) VALUES (1048, 1049, 28, NULL, 1, CAST(N'2020-12-02T15:05:01.843' AS DateTime))
INSERT [dbo].[Candidatura] ([IdCandidatura], [IdCandidato], [IdVaga], [Curriculo], [Visualizado], [DataCriado]) VALUES (1051, 2116, 28, NULL, 1, CAST(N'2020-12-03T15:55:08.917' AS DateTime))
INSERT [dbo].[Candidatura] ([IdCandidatura], [IdCandidato], [IdVaga], [Curriculo], [Visualizado], [DataCriado]) VALUES (1058, 1049, 31, NULL, 0, CAST(N'2020-12-08T15:39:53.243' AS DateTime))
SET IDENTITY_INSERT [dbo].[Candidatura] OFF
INSERT [dbo].[Empresa] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Foto], [Cnae], [Cnpj], [RazaoSocial], [NomeFantasia], [EmailPublico], [Descricao], [TelefoneEmpresa], [CelularEmpresa], [Visualizacao]) VALUES (1050, 2, 1111, N'string', N'4525-6', N'93.007.326/0001-81', N'Consultoria Financeira Ltda', N'Luana TI 2', NULL, N'Somos uma empresa totalmente independente, ou seja, sem produto próprio. 
Dessa forma, proporcionamos aos nossos clientes as melhores soluções financeiras disponíveis no mercado, sendo assim, o nosso trabalho é defender o seu interesse. 
Com o máximo de transparência, buscamos no mercado em geral aquilo que melhor se enquadra aos seus objetivos.', N'(11) 2511-0952', N'(11) 98195-9192', 236)
INSERT [dbo].[Empresa] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Foto], [Cnae], [Cnpj], [RazaoSocial], [NomeFantasia], [EmailPublico], [Descricao], [TelefoneEmpresa], [CelularEmpresa], [Visualizacao]) VALUES (1052, 2, 13, N'string', N'4525-5', N'93.007.326/0001-21', N'Instagram Serviços Online', N'Instagram', N'instagram@webrede.com.br', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tortor pretium viverra suspendisse potenti. Vitae turpis massa sed elementum tempus.', N'(11) 2511-0952', N'(11) 98195-9192', 2307)
INSERT [dbo].[Empresa] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Foto], [Cnae], [Cnpj], [RazaoSocial], [NomeFantasia], [EmailPublico], [Descricao], [TelefoneEmpresa], [CelularEmpresa], [Visualizacao]) VALUES (1078, 2, 59, NULL, N'24668', N'1234567890', N'Rede de tecnologias ', N'Facebook', NULL, N'A rede social permite que você mantenha uma lista de amigos e escolha configurações de privacidade para personalizar quem pode ver o conteúdo em seu perfil.', N'11 2222 2222', N'11 92222 2222', 4)
INSERT [dbo].[Empresa] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Foto], [Cnae], [Cnpj], [RazaoSocial], [NomeFantasia], [EmailPublico], [Descricao], [TelefoneEmpresa], [CelularEmpresa], [Visualizacao]) VALUES (1090, 2, 75, NULL, N'22446', N'12345678968', N'pequena empresa, grandes negócios', N'Pequenos Negócios', NULL, N'Descrição muito legal', N'11 92222 2222', N'11 99222 2222', 13)
INSERT [dbo].[Empresa] ([IdUsuario], [IdStatusUsuario], [IdEndereco], [Foto], [Cnae], [Cnpj], [RazaoSocial], [NomeFantasia], [EmailPublico], [Descricao], [TelefoneEmpresa], [CelularEmpresa], [Visualizacao]) VALUES (1094, 2, 84, NULL, N'1213-4', N'18.381.466/0001-40', N'Space Needle Tecnologia', N'Space', NULL, N'Descrição', N'(99)92020-2002', N'(11)92020-2202', 2)
SET IDENTITY_INSERT [dbo].[Endereco] ON 

INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (2, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (4, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (5, N'01310918', N'Avenida Paulista 1708, Bela Vista, São Paulo - SP', N'SP', -23.56059, -46.6571)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (6, N'03634080', N'Rua do Asilo, Penha de França, São Paulo - SP', N'SP', -23.52503, -46.54857)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (7, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (8, N'01310918', N'Avenida Paulista 1708, Bela Vista, São Paulo - SP', N'SP', -23.56059, -46.6571)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (9, N'03634080', N'Rua do Asilo, Penha de França, São Paulo - SP', N'SP', -23.52503, -46.54857)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (13, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (21, N'05761-200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (22, N'05761-200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (23, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (24, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (25, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (26, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (27, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (38, N'02301050', N'Rua Linete Reis, Vila Paulicéia, São Paulo - SP', N'SP', -23.48969, -46.61551)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (41, N'02222050', N'Vereda Vereador Alfredo Antonini, Jardim Brasil (Zona Norte), São Paulo - SP', N'SP', -23.48199, -46.57907)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (42, N'04407-000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (50, N'04407000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (51, N'04407000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (53, N'04407000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (54, N'02020020', N'Rua das Colônias, Santana, São Paulo - SP', N'SP', -23.49672, -46.63295)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (55, N'02020020', N'Rua das Colônias, Santana, São Paulo - SP', N'SP', -23.49672, -46.63295)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (56, N'04407000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (57, N'05127050', N'Rua Pedro Ladislau de Almeida, Parque São Domingos, São Paulo - SP', N'SP', -23.49772, -46.73808)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (58, N'04407000', N'Rua Professor Álvaro Guimarães Filho, Vila Império, São Paulo - SP', N'SP', -23.66847, -46.65243)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (59, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (60, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (61, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (64, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (65, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (66, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (67, N'01310-932', N'Avenida Paulista 2202, Bela Vista, São Paulo - SP', N'SP', -23.5576, -46.66057)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (68, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (69, N'01001001', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (70, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (71, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (72, N'02301050', N'Rua Linete Reis, Vila Paulicéia, São Paulo - SP', N'SP', -23.48969, -46.61551)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (73, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (74, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (75, N'05761200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (76, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (77, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (78, N'05127-050', N'Rua Pedro Ladislau de Almeida, Parque São Domingos, São Paulo - SP', N'SP', -23.49772, -46.73808)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (80, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (81, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (82, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (83, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (84, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1083, N'08215-263', N'Rua Augusto Carlos Bauman, Itaquera, São Paulo - SP', N'SP', -23.5327, -46.44809)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1084, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1085, N'08215-263', N'Rua Augusto Carlos Bauman, Itaquera, São Paulo - SP', N'SP', -23.5327, -46.44809)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1086, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1087, N'03977-016', N'Rua Francesco Ciampi, Fazenda da Juta, São Paulo - SP', N'SP', -23.62119, -46.49175)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1089, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1090, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1091, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1092, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1093, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1094, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1095, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1096, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1097, N'04427-000', N'Rua Desembargador Olavo Ferreira Prado, Americanópolis, São Paulo - SP', N'SP', -23.67877, -46.65568)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1098, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1099, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1100, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1101, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1102, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1103, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1104, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1105, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1106, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1107, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1108, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1109, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1110, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1111, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1118, N'05127-050', N'Rua Pedro Ladislau de Almeida, Parque São Domingos, São Paulo - SP', N'SP', -23.49772, -46.73808)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1120, N'05127-050', N'Rua Pedro Ladislau de Almeida, Parque São Domingos, São Paulo - SP', N'SP', -23.49772, -46.73808)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1121, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1122, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1133, N'03977-016', N'Rua Francesco Ciampi, Fazenda da Juta, São Paulo - SP', N'SP', -23.62119, -46.49175)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1134, N'05761-200', N'Rua Ernestina Ribeiro Camilo, Jardim Maria Virginia, São Paulo - SP', N'SP', -23.63547, -46.76582)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1136, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1137, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1138, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1139, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1140, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1141, N'01001000', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1142, N'01201000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1164, N'05127-050', N'Rua Pedro Ladislau de Almeida, Parque São Domingos, São Paulo - SP', N'SP', -23.49772, -46.73808)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1165, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1166, N'01001001', N'Praça da Sé, Sé, São Paulo - SP', N'SP', -23.55068, -46.63412)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1167, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1168, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1169, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
INSERT [dbo].[Endereco] ([IdEndereco], [Cep], [LocalCompleto], [Uf], [Lat], [Long]) VALUES (1170, N'01201-000', N'Rua Barão de Campinas, Campos Elíseos, São Paulo - SP', N'SP', -23.53651, -46.64721)
SET IDENTITY_INSERT [dbo].[Endereco] OFF
GO
SET IDENTITY_INSERT [dbo].[Habilidade] ON 

INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (1, NULL, N'.NET')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (2, NULL, N'ABAP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (3, NULL, N'ABNF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (4, NULL, N'Ada')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (5, NULL, N'Administrador de sistema')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (6, NULL, N'Adobe')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (7, NULL, N'Adobe Photoshop')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (8, NULL, N'AdonisJS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (9, NULL, N'ADVPL ASP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (10, NULL, N'Agavi')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (11, NULL, N'Agda')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (12, NULL, N'AgilePHP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (13, NULL, N'AGS Script')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (14, NULL, N'Ajax')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (15, NULL, N'Akelos')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (16, NULL, N'Akka')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (17, NULL, N'Alloy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (18, NULL, N'Alpine Abuild')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (19, NULL, N'Amazon Lambda')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (20, NULL, N'Amazon Redshift')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (21, NULL, N'Amazon S3')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (22, NULL, N'Amazon Web Services')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (23, NULL, N'AMPL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (24, NULL, N'Android')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (25, NULL, N'Android Application Development')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (26, NULL, N'Android Development')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (27, NULL, N'Android SDK')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (28, NULL, N'Android Studio')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (29, NULL, N'Angular JS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (30, NULL, N'Ansible')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (31, NULL, N'Ant Build System')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (32, NULL, N'ANTLR')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (33, NULL, N'Apache')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (34, NULL, N'Apache Cassandra')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (35, NULL, N'Apache Kafka')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (36, NULL, N'Apache Solr')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (37, NULL, N'Apache Storm')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (38, NULL, N'Apache Tomcat')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (39, NULL, N'Apex')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (40, NULL, N'API')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (41, NULL, N'APL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (42, NULL, N'Apollo Guidance Computer')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (43, NULL, N'AppleScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (44, NULL, N'Application deployment (Docker)')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (45, NULL, N'Arc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (46, NULL, N'Arduino')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (47, NULL, N'ARKit')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (48, NULL, N'AsciiDoc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (49, NULL, N'ASN.1')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (50, NULL, N'ASP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (51, NULL, N'ASP.NET Core')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (52, NULL, N'ASP.NET MVC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (53, NULL, N'AspectJ')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (54, NULL, N'Assembly')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (55, NULL, N'Atomik')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (56, NULL, N'ATS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (57, NULL, N'Augeas')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (58, NULL, N'Aura')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (59, NULL, N'Aurelia')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (60, NULL, N'AutoHotkey')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (61, NULL, N'AutoIt')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (62, NULL, N'Automation')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (63, NULL, N'Autonomia')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (64, NULL, N'Awk')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (65, NULL, N'AWS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (66, NULL, N'AWS Cloud Services')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (67, NULL, N'AWS EC2 (Elastic Compute Cloud)')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (68, NULL, N'AWS Lambda')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (69, NULL, N'AWS RDS (Relational Database Service)')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (70, NULL, N'AWS S3')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (71, NULL, N'BabelJS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (72, NULL, N'Backbone.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (73, NULL, N'Backendless')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (74, NULL, N'Banco de Dados')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (75, NULL, N'Bash')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (76, NULL, N'Bash Scripting')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (77, NULL, N'Batchfile')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (78, NULL, N'Beego')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (79, NULL, N'Befunge')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (80, NULL, N'Big Data')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (81, NULL, N'Bison')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (82, NULL, N'BitBake')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (83, NULL, N'Bitbucket')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (84, NULL, N'Blade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (85, NULL, N'BlitzBasic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (86, NULL, N'BlitzMax')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (87, NULL, N'Bluespec')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (88, NULL, N'Boo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (89, NULL, N'Bootstrap')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (90, NULL, N'Bottle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (91, NULL, N'Brainfuck')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (92, NULL, N'Brightscript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (93, NULL, N'Bro')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (94, NULL, N'Brutos')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (95, NULL, N'Business Development')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (96, NULL, N'C')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (97, NULL, N'C-ObjDump')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (98, NULL, N'C#')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (99, NULL, N'C++')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (100, NULL, N'C2hs Haskell')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (101, NULL, N'Cairngorm')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (102, NULL, N'CakePHP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (103, NULL, N'Camping')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (104, NULL, N'Cap''n Proto')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (105, NULL, N'Capacidade de concentração')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (106, NULL, N'Capacidade de organização')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (107, NULL, N'Cappuccino')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (108, NULL, N'CartoCSS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (109, NULL, N'Cascading Style Sheet (CSS)')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (110, NULL, N'Cassandra')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (111, NULL, N'Catalyst')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (112, NULL, N'Celery')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (113, NULL, N'Ceylon')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (114, NULL, N'CGI::Application')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (115, NULL, N'CGI::Prototype')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (116, NULL, N'Chapel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (117, NULL, N'Charity')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (118, NULL, N'Chef')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (119, NULL, N'CherryPy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (120, NULL, N'ChucK')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (121, NULL, N'Circumflex')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (122, NULL, N'Cirru')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (123, NULL, N'Clarion')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (124, NULL, N'Clean')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (125, NULL, N'ClearPress')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (126, NULL, N'Click')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (127, NULL, N'CLIPS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (128, NULL, N'Clojure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (129, NULL, N'Cloud')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (130, NULL, N'CMake')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (131, NULL, N'COBOL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (132, NULL, N'Cocoon')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (133, NULL, N'CodeIgniter')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (134, NULL, N'Coffeescript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (135, NULL, N'Colaboração')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (136, NULL, N'ColdFusion')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (137, NULL, N'ColdFusion CFC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (138, NULL, N'COLLADA')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (139, NULL, N'Common Lisp')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (140, NULL, N'Competência intercultural')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (141, NULL, N'Compojure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (142, NULL, N'Component Pascal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (143, NULL, N'CompoundJS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (144, NULL, N'Comunicação efetiva')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (145, NULL, N'Conjure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (146, NULL, N'Consulting')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (147, NULL, N'Continuous Deployment')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (148, NULL, N'Continuous Integration')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (149, NULL, N'Cool')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (150, NULL, N'Coq')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (151, NULL, N'Cordova')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (152, NULL, N'Core Java / Java SE')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (153, NULL, N'Cpp-ObjDump')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (154, NULL, N'Creole')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (155, NULL, N'Criatividade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (156, NULL, N'Crystal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (157, NULL, N'CSON')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (158, NULL, N'Csound')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (159, NULL, N'Csound Document')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (160, NULL, N'Csound Score')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (161, NULL, N'CSS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (162, NULL, N'CSS3')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (163, NULL, N'CSV')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (164, NULL, N'Cuba')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (165, NULL, N'Cucumber')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (166, NULL, N'Cuda')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (167, NULL, N'Customer Relationship Management')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (168, NULL, N'Customer Service')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (169, NULL, N'Cutelyst')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (170, NULL, N'Cyclone3')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (171, NULL, N'Cycript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (172, NULL, N'Cython')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (173, NULL, N'D')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (174, NULL, N'D-ObjDump')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (175, NULL, N'D3.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (176, NULL, N'Darcs Patch')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (177, NULL, N'Dart')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (178, NULL, N'Data Analysis')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (179, NULL, N'Data Management')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (180, NULL, N'Data Science')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (181, NULL, N'Data Warehouse')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (182, NULL, N'Delphi')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (183, NULL, N'Demandware')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (184, NULL, N'Design')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (185, NULL, N'Design de Banco de Dados e Sistemas')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (186, NULL, N'Design Pattern')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (187, NULL, N'Dev Ops')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (188, NULL, N'Diff')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (189, NULL, N'DIGITAL Command Language')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (190, NULL, N'Django')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (191, NULL, N'DM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (192, NULL, N'DNS Zone')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (193, NULL, N'Docker')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (194, NULL, N'Doctrine')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (195, NULL, N'Dogescript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (196, NULL, N'Dojo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (197, NULL, N'Dropwizard')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (198, NULL, N'Drupal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (199, NULL, N'DTrace')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (200, NULL, N'Durandal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (201, NULL, N'Dylan')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (202, NULL, N'DynamoDB')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (203, NULL, N'Eagle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (204, NULL, N'EBNF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (205, NULL, N'eC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (206, NULL, N'Ecere Projects')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (207, NULL, N'ECL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (208, NULL, N'Eclipse')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (209, NULL, N'Edn')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (210, NULL, N'Eiffel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (211, NULL, N'EJB')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (212, NULL, N'EJS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (213, NULL, N'ElasticSearch')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (214, NULL, N'Eliom')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (215, NULL, N'Elixir')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (216, NULL, N'Elm')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (217, NULL, N'Emacs Lisp')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (218, NULL, N'Email')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (219, NULL, N'Ember.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (220, NULL, N'EmberScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (221, NULL, N'Engineering')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (222, NULL, N'Entity framework')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (223, NULL, N'EQ')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (224, NULL, N'Erlang')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (225, NULL, N'Erlang Web')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (226, NULL, N'ErlyWeb')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (227, NULL, N'ERP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (228, NULL, N'ES6')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (229, NULL, N'Esforço')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (230, NULL, N'ETL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (231, NULL, N'Excel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (232, NULL, N'Express')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (233, NULL, N'F#')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (234, NULL, N'Facebook API')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (235, NULL, N'Factor')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (236, NULL, N'Fancy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (237, NULL, N'Fantom')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (238, NULL, N'Feathers')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (239, NULL, N'Filebench WML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (240, NULL, N'Filterscript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (241, NULL, N'Firebase')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (242, NULL, N'Fish')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (243, NULL, N'Flask')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (244, NULL, N'Flatiron')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (245, NULL, N'Flex')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (246, NULL, N'Flexibilidade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (247, NULL, N'Flight')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (248, NULL, N'Flutter')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (249, NULL, N'FLUX')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (250, NULL, N'Força de vontande')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (251, NULL, N'Formatted')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (252, NULL, N'Forth')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (253, NULL, N'FORTRAN')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (254, NULL, N'FreeMarker')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (255, NULL, N'Frege')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (256, NULL, N'FuelPHP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (257, NULL, N'G-code')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (258, NULL, N'Game Maker Language')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (259, NULL, N'GAMS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (260, NULL, N'Gantry')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (261, NULL, N'GAP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (262, NULL, N'Garantia de Qualidade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (263, NULL, N'GAS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (264, NULL, N'GCC Machine Description')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (265, NULL, N'GDB')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (266, NULL, N'GDScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (267, NULL, N'Genshi')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (268, NULL, N'Gentoo Ebuild')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (269, NULL, N'Gentoo Eclass')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (270, NULL, N'Gerenciamento de Banco de Dados')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (271, NULL, N'Gettext Catalog')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (272, NULL, N'Gin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (273, NULL, N'Git')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (274, NULL, N'Github')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (275, NULL, N'GLSL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (276, NULL, N'Glyph')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (277, NULL, N'GN')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (278, NULL, N'Gnuplot')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (279, NULL, N'Go')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (280, NULL, N'Golo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (281, NULL, N'Google Analytics')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (282, NULL, N'Google Cloud')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (283, NULL, N'Google Maps API')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (284, NULL, N'Google Web Toolkit')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (285, NULL, N'Gosu')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (286, NULL, N'Grace')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (287, NULL, N'Gradle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (288, NULL, N'Grails')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (289, NULL, N'Grain')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (290, NULL, N'Grammatical Framework')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (291, NULL, N'Graph Modeling Language')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (292, NULL, N'GraphQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (293, NULL, N'Graphviz (DOT)')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (294, NULL, N'Groff')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (295, NULL, N'Grok')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (296, NULL, N'Groovy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (297, NULL, N'Groovy Server Pages')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (298, NULL, N'Grunt')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (299, NULL, N'Gulp')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (300, NULL, N'GWT')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (301, NULL, N'Hack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (302, NULL, N'Hadoop')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (303, NULL, N'Halcyon')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (304, NULL, N'Haml')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (305, NULL, N'Hanami')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (306, NULL, N'Handlebars')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (307, NULL, N'Happstack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (308, NULL, N'Harbour')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (309, NULL, N'Haskell')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (310, NULL, N'Haxe')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (311, NULL, N'Hbase')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (312, NULL, N'HCL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (313, NULL, N'Hemlock')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (314, NULL, N'Heroku')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (315, NULL, N'Hibernate')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (316, NULL, N'Hindi Language')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (317, NULL, N'Hive')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (318, NULL, N'HLSL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (319, NULL, N'Horde')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (320, NULL, N'HTML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (321, NULL, N'HTML5')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (322, NULL, N'HTTP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (323, NULL, N'Human Resources')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (324, NULL, N'Hy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (325, NULL, N'HybridJava')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (326, NULL, N'Hybris')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (327, NULL, N'HydraMVC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (328, NULL, N'HyPhy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (329, NULL, N'IDL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (330, NULL, N'Idris')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (331, NULL, N'IGOR Pro')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (332, NULL, N'Inform 7')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (333, NULL, N'Infrastructure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (334, NULL, N'Inglês')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (335, NULL, N'INI')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (336, NULL, N'Iniciativa')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (337, NULL, N'Inno Setup')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (338, NULL, N'Inovação')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (339, NULL, N'Integrity')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (340, NULL, N'Inteligência emocional')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (341, NULL, N'Inventory')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (342, NULL, N'Io')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (343, NULL, N'Ioke')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (344, NULL, N'Ionic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (345, NULL, N'iOS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (346, NULL, N'iOS Development')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (347, NULL, N'IRC log')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (348, NULL, N'Ireport')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (349, NULL, N'Isabelle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (350, NULL, N'J')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (351, NULL, N'Jade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (352, NULL, N'Jasmin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (353, NULL, N'Jasper')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (354, NULL, N'Java')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (355, NULL, N'Java Server Pages')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (356, NULL, N'JavaEE')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (357, NULL, N'JavaScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (358, NULL, N'Javascript Frameworks')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (359, NULL, N'JavaScriptMVC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (360, NULL, N'Jenkins')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (361, NULL, N'JFlex')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (362, NULL, N'Jifty')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (363, NULL, N'JMeter')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (364, NULL, N'jQuery')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (365, NULL, N'jQuery Mobile')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (366, NULL, N'JSF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (367, NULL, N'JSON')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (368, NULL, N'JSX')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (369, NULL, N'Julia')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (370, NULL, N'JUNIT')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (371, NULL, N'Jupyter Notebook')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (372, NULL, N'JVM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (373, NULL, N'Kafka')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (374, NULL, N'Kanban')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (375, NULL, N'KiCad')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (376, NULL, N'Kit')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (377, NULL, N'Koa')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (378, NULL, N'Kohana')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (379, NULL, N'Konstrukt')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (380, NULL, N'Kotlin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (381, NULL, N'KRL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (382, NULL, N'Kubernetes')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (383, NULL, N'KumbiaPHP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (384, NULL, N'LabVIEW')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (385, NULL, N'Laravel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (386, NULL, N'Lasso')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (387, NULL, N'Latte')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (388, NULL, N'Leadership')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (389, NULL, N'Lean')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (390, NULL, N'Lemmachine')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (391, NULL, N'Less')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (392, NULL, N'Lex')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (393, NULL, N'LFE')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (394, NULL, N'Liderança')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (395, NULL, N'Lift')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (396, NULL, N'LilyPond')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (397, NULL, N'Limbo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (398, NULL, N'Linker Script')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (399, NULL, N'Linux')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (400, NULL, N'Linux Kernel Module')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (401, NULL, N'Linux System Administration')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (402, NULL, N'Liquid')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (403, NULL, N'LiquidLava')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (404, NULL, N'Literate Agda')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (405, NULL, N'Literate CoffeeScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (406, NULL, N'Literate Haskell')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (407, NULL, N'Lithium')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (408, NULL, N'LiveScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (409, NULL, N'LLVM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (410, NULL, N'Logos')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (411, NULL, N'Logtalk')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (412, NULL, N'LOLCODE')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (413, NULL, N'LookML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (414, NULL, N'LoomScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (415, NULL, N'LSL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (416, NULL, N'Lua')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (417, NULL, N'LUMEN')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (418, NULL, N'M')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (419, NULL, N'M4')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (420, NULL, N'M4Sugar')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (421, NULL, N'Machine learning')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (422, NULL, N'Mack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (423, NULL, N'Magento')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (424, NULL, N'Makefile')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (425, NULL, N'Mako')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (426, NULL, N'Management')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (427, NULL, N'Markdown')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (428, NULL, N'Marketing')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (429, NULL, N'Martini')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (430, NULL, N'Mask')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (431, NULL, N'Mason')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (432, NULL, N'Mate')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (433, NULL, N'Mathematica')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (434, NULL, N'Matlab')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (435, NULL, N'Maven POM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (436, NULL, N'Maveric')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (437, NULL, N'Max')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (438, NULL, N'MAXScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (439, NULL, N'MediaWiki')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (440, NULL, N'Memcached')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (441, NULL, N'Merb')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (442, NULL, N'Mercury')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (443, NULL, N'Metal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (444, NULL, N'Meteor')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (445, NULL, N'MFlow')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (446, NULL, N'Microsoft')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (447, NULL, N'Microsoft Azure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (448, NULL, N'Microsoft Excel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (449, NULL, N'Microsoft Office')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (450, NULL, N'Microsoft PowerPoint')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (451, NULL, N'Microsoft SQL Server')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (452, NULL, N'Microsoft Windows')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (453, NULL, N'Microsoft Word')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (454, NULL, N'MiniD')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (455, NULL, N'Mirah')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (456, NULL, N'Mithril')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (457, NULL, N'Modelica')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (458, NULL, N'Modula-2')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (459, NULL, N'Module Management System')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (460, NULL, N'Mojolicious')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (461, NULL, N'MongoDB')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (462, NULL, N'Monkey')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (463, NULL, N'Moocode')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (464, NULL, N'MoonScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (465, NULL, N'Moustache')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (466, NULL, N'MQL4')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (467, NULL, N'MQL5')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (468, NULL, N'MS SQL Server')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (469, NULL, N'MTML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (470, NULL, N'MUF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (471, NULL, N'Mupad')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (472, NULL, N'Myghty')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (473, NULL, N'MySQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (474, NULL, N'Nancy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (475, NULL, N'NCL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (476, NULL, N'Nemerle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (477, NULL, N'Neo4J')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (478, NULL, N'Nerve')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (479, NULL, N'NesC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (480, NULL, N'NetLinx')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (481, NULL, N'NetLogo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (482, NULL, N'Networking')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (483, NULL, N'NewLisp')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (484, NULL, N'Nginx')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (485, NULL, N'Nimrod')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (486, NULL, N'Ninja')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (487, NULL, N'Nit')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (488, NULL, N'Nitro')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (489, NULL, N'Nix')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (490, NULL, N'NL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (491, NULL, N'Node-router')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (492, NULL, N'Node.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (493, NULL, N'Nodemachine')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (494, NULL, N'Noir')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (495, NULL, N'NoSQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (496, NULL, N'NPM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (497, NULL, N'NSIS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (498, NULL, N'Nu')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (499, NULL, N'NumPy')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (500, NULL, N'ObjDump')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (501, NULL, N'Objective-C')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (502, NULL, N'Objective-C++')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (503, NULL, N'Objective-J')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (504, NULL, N'OCaml')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (505, NULL, N'Odoo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (506, NULL, N'Omgrofl')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (507, NULL, N'Ooc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (508, NULL, N'Opa')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (509, NULL, N'Opal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (510, NULL, N'OpenCL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (511, NULL, N'OpenCV')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (512, NULL, N'OpenEdge ABL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (513, NULL, N'OpenGL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (514, NULL, N'OpenRC runscript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (515, NULL, N'OpenSCAD')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (516, NULL, N'OpenType Feature File')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (517, NULL, N'OpenUI5')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (518, NULL, N'Operações')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (519, NULL, N'Oracle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (520, NULL, N'Orbit')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (521, NULL, N'Org')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (522, NULL, N'Ox')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (523, NULL, N'Oxygene')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (524, NULL, N'Oz')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (525, NULL, N'Pan')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (526, NULL, N'Papyrus')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (527, NULL, N'Parrot')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (528, NULL, N'Parrot Assembly')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (529, NULL, N'Parrot Internal Representation')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (530, NULL, N'Pascal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (531, NULL, N'PAWN')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (532, NULL, N'Pensamento crítico')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (533, NULL, N'PeopleCode')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (534, NULL, N'Perfect')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (535, NULL, N'Perl')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (536, NULL, N'Perl6')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (537, NULL, N'Phalcon')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (538, NULL, N'Phoenix')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (539, NULL, N'PhoneGap')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (540, NULL, N'Photoshop')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (541, NULL, N'PHP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (542, NULL, N'Pic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (543, NULL, N'Picard')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (544, NULL, N'Pickle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (545, NULL, N'PicoLisp')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (546, NULL, N'PigLatin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (547, NULL, N'Pike')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (548, NULL, N'Planning')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (549, NULL, N'Play')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (550, NULL, N'PLpgSQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (551, NULL, N'PLSQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (552, NULL, N'Pod')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (553, NULL, N'PogoScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (554, NULL, N'Polymer')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (555, NULL, N'Pony')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (556, NULL, N'POO')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (557, NULL, N'PostgreSQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (558, NULL, N'PostScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (559, NULL, N'POV-Ray SDL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (560, NULL, N'PowerBuilder')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (561, NULL, N'PowerShell')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (562, NULL, N'Prado')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (563, NULL, N'Processing')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (564, NULL, N'Product Management')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (565, NULL, N'Produtividade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (566, NULL, N'Programming')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (567, NULL, N'Progress')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (568, NULL, N'Project Management')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (569, NULL, N'Prolog')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (570, NULL, N'Propeller Spin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (571, NULL, N'Protocol Buffer')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (572, NULL, N'Prototyping')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (573, NULL, N'Public Key')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (574, NULL, N'Puppet')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (575, NULL, N'Pure Data')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (576, NULL, N'PureBasic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (577, NULL, N'PureMVC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (578, NULL, N'PureScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (579, NULL, N'Pyramid')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (580, NULL, N'Python')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (581, NULL, N'Qcodo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (582, NULL, N'QCubed')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (583, NULL, N'Qlikview')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (584, NULL, N'QMake')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (585, NULL, N'QML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (586, NULL, N'Quixote')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (587, NULL, N'R')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (588, NULL, N'Rabbitmq')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (589, NULL, N'Racket')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (590, NULL, N'Ragel in Ruby Host')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (591, NULL, N'Ramaze')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (592, NULL, N'RAML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (593, NULL, N'Rascal')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (594, NULL, N'Ratpack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (595, NULL, N'Raw token data')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (596, NULL, N'RDBMS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (597, NULL, N'RDoc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (598, NULL, N'React Native')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (599, NULL, N'ReactJS')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (600, NULL, N'REALbasic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (601, NULL, N'Rebol')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (602, NULL, N'Red')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (603, NULL, N'Redcode')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (604, NULL, N'Redis')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (605, NULL, N'Redux')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (606, NULL, N'Relational Databases')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (607, NULL, N'Ren''Py')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (608, NULL, N'RenderScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (609, NULL, N'Research')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (610, NULL, N'Resolução de problemas')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (611, NULL, N'Responsabilidade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (612, NULL, N'REST APIs')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (613, NULL, N'RESTful')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (614, NULL, N'RestfulX')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (615, NULL, N'Restlet')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (616, NULL, N'reStructuredText')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (617, NULL, N'Retail')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (618, NULL, N'Revel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (619, NULL, N'REXX')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (620, NULL, N'RHTML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (621, NULL, N'Ring')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (622, NULL, N'Riot.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (623, NULL, N'RMarkdown')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (624, NULL, N'RobotFramework')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (625, NULL, N'Roma')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (626, NULL, N'Rouge')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (627, NULL, N'RPM Spec')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (628, NULL, N'Rspec')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (629, NULL, N'Ruby')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (630, NULL, N'Ruby on Rails')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (631, NULL, N'Rum')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (632, NULL, N'RUNOFF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (633, NULL, N'Rust')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (634, NULL, N'Sage')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (635, NULL, N'Sails.js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (636, NULL, N'Sales')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (637, NULL, N'Salesforce')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (638, NULL, N'Salesforce Developer')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (639, NULL, N'SaltStack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (640, NULL, N'Salvia')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (641, NULL, N'SAP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (642, NULL, N'SAS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (643, NULL, N'Sass')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (644, NULL, N'Scala')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (645, NULL, N'Scalatra')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (646, NULL, N'Scaml')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (647, NULL, N'Scheme')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (648, NULL, N'Scilab')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (649, NULL, N'SCORM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (650, NULL, N'Scripting Languages')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (651, NULL, N'SCRUM')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (652, NULL, N'SCSS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (653, NULL, N'Seagull')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (654, NULL, N'Security')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (655, NULL, N'Selenium')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (656, NULL, N'Selenium WebDriver')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (657, NULL, N'Self')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (658, NULL, N'Servant')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (659, NULL, N'Servers')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (660, NULL, N'Services')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (661, NULL, N'Sharepoint')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (662, NULL, N'Shell')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (663, NULL, N'Shell Script')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (664, NULL, N'Shell Scripting')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (665, NULL, N'ShellSession')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (666, NULL, N'Shen')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (667, NULL, N'Shopify')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (668, NULL, N'SilverStripe Sapphire')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (669, NULL, N'Sin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (670, NULL, N'Sinatra')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (671, NULL, N'Slash')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (672, NULL, N'Slim')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (673, NULL, N'Smali')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (674, NULL, N'Smalltalk')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (675, NULL, N'Smarty')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (676, NULL, N'SMT')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (677, NULL, N'Snap')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (678, NULL, N'Sociabilidade')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (679, NULL, N'Socket.io')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (680, NULL, N'Software')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (681, NULL, N'Solar')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (682, NULL, N'SourcePawn')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (683, NULL, N'Spark')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (684, NULL, N'SPARQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (685, NULL, N'Spline Font Database')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (686, NULL, N'Spring')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (687, NULL, N'SproutCore')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (688, NULL, N'SQF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (689, NULL, N'SQL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (690, NULL, N'SQL Server')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (691, NULL, N'SQLite')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (692, NULL, N'SQLPL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (693, NULL, N'SQR')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (694, NULL, N'Squatting')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (695, NULL, N'Squirrel')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (696, NULL, N'SRecode Template')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (697, NULL, N'Stan')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (698, NULL, N'Standard ML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (699, NULL, N'Stata')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (700, NULL, N'STON')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (701, NULL, N'Stripes')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (702, NULL, N'Struts')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (703, NULL, N'Styled-Components')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (704, NULL, N'Stylus')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (705, NULL, N'Sublime Text')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (706, NULL, N'SubRip Text')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (707, NULL, N'SuperCollider')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (708, NULL, N'Support')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (709, NULL, N'SVG')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (710, NULL, N'Svn')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (711, NULL, N'Sweetcala')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (712, NULL, N'Swift')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (713, NULL, N'Swiftlet')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (714, NULL, N'Swiz')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (715, NULL, N'Symfony')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (716, NULL, N'SystemVerilog')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (717, NULL, N'Tapestry')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (718, NULL, N'TCL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (719, NULL, N'TCP/IP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (720, NULL, N'Tcsh')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (721, NULL, N'Tea')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (722, NULL, N'Técnologia da Informação')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (723, NULL, N'TensorFlow')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (724, NULL, N'Terra')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (725, NULL, N'Terraform')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (726, NULL, N'Test')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (727, NULL, N'Testes automatizados')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (728, NULL, N'Testes unitários')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (729, NULL, N'TeX')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (730, NULL, N'Text')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (731, NULL, N'Textile')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (732, NULL, N'Thrift')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (733, NULL, N'TI Program')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (734, NULL, N'Tipfy')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (735, NULL, N'TLA')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (736, NULL, N'Tomcat')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (737, NULL, N'TOML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (738, NULL, N'Tornado')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (739, NULL, N'Trabalho em equipe')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (740, NULL, N'Training')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (741, NULL, N'Turbine')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (742, NULL, N'TurboGears')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (743, NULL, N'Turing')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (744, NULL, N'Turtle')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (745, NULL, N'Twig')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (746, NULL, N'TXL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (747, NULL, N'TypeScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (748, NULL, N'Ubuntu')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (749, NULL, N'UKI')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (750, NULL, N'UML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (751, NULL, N'Unified Parallel C')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (752, NULL, N'Unity')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (753, NULL, N'Unity3D Asset')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (754, NULL, N'Unix')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (755, NULL, N'Uno')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (756, NULL, N'Unreal Engine 4')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (757, NULL, N'UnrealScript')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (758, NULL, N'UrWeb')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (759, NULL, N'Vaadin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (760, NULL, N'Vagrant')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (761, NULL, N'Vala')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (762, NULL, N'Vanilla')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (763, NULL, N'Vapor')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (764, NULL, N'VBA')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (765, NULL, N'VCL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (766, NULL, N'Verilog')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (767, NULL, N'Vert.x')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (768, NULL, N'VHDL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (769, NULL, N'VimL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (770, NULL, N'Visual Basic')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (771, NULL, N'Volt')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (772, NULL, N'Vork')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (773, NULL, N'Vroom')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (774, NULL, N'Vue.Js')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (775, NULL, N'Wavefront Material')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (776, NULL, N'Wavefront Object')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (777, NULL, N'Waves')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (778, NULL, N'Web')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (779, NULL, N'Web API')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (780, NULL, N'Web Application Frameworks')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (781, NULL, N'Web Ontology Language')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (782, NULL, N'Web Services')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (783, NULL, N'Web Technologies')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (784, NULL, N'Web2py')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (785, NULL, N'WebGL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (786, NULL, N'WebGUI')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (787, NULL, N'WebIDL')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (788, NULL, N'Webjure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (789, NULL, N'Webpack')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (790, NULL, N'WebRTC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (791, NULL, N'Websockets')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (792, NULL, N'Wee')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (793, NULL, N'Wicket')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (794, NULL, N'Windows Azure')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (795, NULL, N'Wisp')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (796, NULL, N'WordPress')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (797, NULL, N'World of Warcraft Addon Data')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (798, NULL, N'WPF')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (799, NULL, N'X10')
GO
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (800, NULL, N'Xamarin')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (801, NULL, N'xBase')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (802, NULL, N'XC')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (803, NULL, N'Xcode')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (804, NULL, N'Xitrum')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (805, NULL, N'XML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (806, NULL, N'XMPP')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (807, NULL, N'Xojo')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (808, NULL, N'XPages')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (809, NULL, N'XProc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (810, NULL, N'XQuery')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (811, NULL, N'XS')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (812, NULL, N'XSLT')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (813, NULL, N'Xtend')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (814, NULL, N'Xyster')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (815, NULL, N'Yacc')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (816, NULL, N'YAML')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (817, NULL, N'YANG')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (818, NULL, N'Yesod')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (819, NULL, N'Yii')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (820, NULL, N'Zend')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (821, NULL, N'Zephir')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (822, NULL, N'Zepto')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (823, NULL, N'Zimpl')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (824, NULL, N'ZK')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (825, NULL, N'Zope')
INSERT [dbo].[Habilidade] ([IdHabilidade], [IdCriadoPor], [NomeHabilidade]) VALUES (826, NULL, N'Zotonic')
SET IDENTITY_INSERT [dbo].[Habilidade] OFF
SET IDENTITY_INSERT [dbo].[HabilidadeCandidato] ON 

INSERT [dbo].[HabilidadeCandidato] ([IdHabilidadeCandidato], [IdHabilidade], [IdCandidato]) VALUES (41, 13, 2116)
INSERT [dbo].[HabilidadeCandidato] ([IdHabilidadeCandidato], [IdHabilidade], [IdCandidato]) VALUES (42, 15, 2116)
SET IDENTITY_INSERT [dbo].[HabilidadeCandidato] OFF
SET IDENTITY_INSERT [dbo].[HabilidadeVaga] ON 

INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (33, 99, 26)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (34, 96, 26)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (35, 264, 26)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (39, 354, 28)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (40, 96, 29)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (41, 264, 29)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (42, 399, 29)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (43, 424, 29)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (47, 598, 31)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (48, 24, 31)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (1070, 598, 1041)
INSERT [dbo].[HabilidadeVaga] ([IdHabilidadeVaga], [IdHabilidade], [IdVaga]) VALUES (1071, 599, 1041)
SET IDENTITY_INSERT [dbo].[HabilidadeVaga] OFF
SET IDENTITY_INSERT [dbo].[Matching] ON 

INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56157, 26, 1049, 25.96, 7.04)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56158, 26, 1075, 12.77, 20.23)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56159, 26, 2116, 10.7, 22.3)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56160, 26, 2139, 20.47, 12.53)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56161, 28, 1049, 30.94, 2.06)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56162, 28, 1075, 18.32, 14.68)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56163, 28, 2116, 16.66, 16.34)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56164, 28, 2139, 22.78, 10.22)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56165, 29, 1049, 30.94, 2.06)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56166, 29, 1075, 18.32, 14.68)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56167, 29, 2116, 16.66, 16.34)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56168, 29, 2139, 22.78, 10.22)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56169, 31, 1049, 30.94, 2.06)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56170, 31, 1075, 18.32, 14.68)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56171, 31, 2116, 16.66, 16.34)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56172, 31, 2139, 22.78, 10.22)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56173, 1041, 1049, 30.94, 2.06)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56174, 1041, 1075, 18.32, 14.68)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56175, 1041, 2116, 16.66, 16.34)
INSERT [dbo].[Matching] ([IdMatching], [IdVaga], [idCandidato], [Porcentagem], [Distancia]) VALUES (56176, 1041, 2139, 22.78, 10.22)
SET IDENTITY_INSERT [dbo].[Matching] OFF
SET IDENTITY_INSERT [dbo].[Notificacao] ON 

INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (12, CAST(N'2020-11-09T14:02:39.147' AS DateTime), N'Empresa Grandes Negócios se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (13, CAST(N'2020-11-09T14:07:14.017' AS DateTime), N'Empresa Grandes Negócios cadastrou a vaga Desenvolvedor React Native.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (14, CAST(N'2020-11-09T14:08:37.500' AS DateTime), N'Candidato João da Silva se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (15, CAST(N'2020-11-10T11:18:29.957' AS DateTime), N'Empresa teste se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (16, CAST(N'2020-11-13T14:14:40.290' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (17, CAST(N'2020-11-13T14:19:32.353' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (18, CAST(N'2020-11-13T15:21:22.023' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (19, CAST(N'2020-11-13T15:23:33.540' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (20, CAST(N'2020-11-13T15:30:17.547' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (21, CAST(N'2020-11-13T15:31:20.770' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (22, CAST(N'2020-11-13T15:32:12.663' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (23, CAST(N'2020-11-13T15:32:42.923' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (24, CAST(N'2020-11-13T15:33:07.447' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (25, CAST(N'2020-11-13T15:36:36.053' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (26, CAST(N'2020-11-13T15:36:51.463' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (27, CAST(N'2020-11-13T15:37:16.470' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (28, CAST(N'2020-11-13T15:45:34.490' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (29, CAST(N'2020-11-13T15:45:59.673' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (30, CAST(N'2020-11-13T15:46:14.680' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (31, CAST(N'2020-11-13T15:52:46.877' AS DateTime), N'Empresa Luana TI foi recusada.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (32, CAST(N'2020-11-13T16:34:17.623' AS DateTime), N'Empresa Luana TI foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (33, CAST(N'2020-11-13T17:33:27.020' AS DateTime), N'Empresa Luana TI cadastrou a vaga Desenvolvedor de Sistemas.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (34, CAST(N'2020-11-24T15:00:08.060' AS DateTime), N'Empresa Luana TI cadastrou a vaga Desenvolvedor C.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (35, CAST(N'2020-11-24T15:06:40.043' AS DateTime), N'Empresa Space se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (36, CAST(N'2020-11-24T15:07:30.877' AS DateTime), N'Empresa Space foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1034, CAST(N'2020-11-26T17:36:58.780' AS DateTime), N'Empresa teste se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1035, CAST(N'2020-12-02T12:00:55.843' AS DateTime), N'Empresa 123 se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1036, CAST(N'2020-12-02T12:01:38.313' AS DateTime), N'Empresa 123 foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1037, CAST(N'2020-12-02T12:03:34.150' AS DateTime), N'Empresa 123 cadastrou a vaga vaga para teste.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1038, CAST(N'2020-12-02T15:08:51.003' AS DateTime), N'Empresa Luana TI cadastrou a vaga Desenvolvedor React Native.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1039, CAST(N'2020-12-02T15:12:07.457' AS DateTime), N'Empresa teste foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1040, CAST(N'2020-12-02T15:13:32.993' AS DateTime), N'Candidato João Augusto se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1041, CAST(N'2020-12-02T17:07:15.203' AS DateTime), N'Candidato teste se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1042, CAST(N'2020-12-02T17:13:02.893' AS DateTime), N'Candidato marina souza se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1043, CAST(N'2020-12-14T18:53:16.743' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga teste 2.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1044, CAST(N'2020-12-14T19:20:35.773' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga Teste 3.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1045, CAST(N'2020-12-15T14:19:08.383' AS DateTime), N'Candidato Murilo Luiz Barbosa Gomes se cadastrou.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1046, CAST(N'2020-12-15T15:11:40.803' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga Teste 3.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1047, CAST(N'2020-12-16T17:24:17.653' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga Teste 4.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1048, CAST(N'2020-12-16T17:26:44.823' AS DateTime), N'Empresa Facebook foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1049, CAST(N'2020-12-16T17:36:13.617' AS DateTime), N'Empresa Luana TI 2 cadastrou a vaga Vaga Teste 5.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1050, CAST(N'2020-12-16T17:38:43.160' AS DateTime), N'Empresa Facebook foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1051, CAST(N'2020-12-17T15:20:19.240' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga Teste 4.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1052, CAST(N'2020-12-17T15:23:14.070' AS DateTime), N'Empresa Facebook foi aceita.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1053, CAST(N'2020-12-17T15:56:54.780' AS DateTime), N'Empresa Luana TI cadastrou a vaga Vaga Teste 4.')
INSERT [dbo].[Notificacao] ([IdNotificacao], [DataNotificacao], [Mensagem]) VALUES (1054, CAST(N'2020-12-17T15:59:34.780' AS DateTime), N'Empresa Facebook foi aceita.')
SET IDENTITY_INSERT [dbo].[Notificacao] OFF
SET IDENTITY_INSERT [dbo].[StatusUsuario] ON 

INSERT [dbo].[StatusUsuario] ([IdStatusUsuario], [NomeStatus]) VALUES (1, N'Pendente')
INSERT [dbo].[StatusUsuario] ([IdStatusUsuario], [NomeStatus]) VALUES (2, N'Ativo')
INSERT [dbo].[StatusUsuario] ([IdStatusUsuario], [NomeStatus]) VALUES (3, N'Bloqueado')
INSERT [dbo].[StatusUsuario] ([IdStatusUsuario], [NomeStatus]) VALUES (4, N'Recusado')
SET IDENTITY_INSERT [dbo].[StatusUsuario] OFF
SET IDENTITY_INSERT [dbo].[TipoUsuario] ON 

INSERT [dbo].[TipoUsuario] ([IdTipoUsuario], [Nome]) VALUES (1, N'Administrador')
INSERT [dbo].[TipoUsuario] ([IdTipoUsuario], [Nome]) VALUES (2, N'Empresa')
INSERT [dbo].[TipoUsuario] ([IdTipoUsuario], [Nome]) VALUES (3, N'Candidato')
SET IDENTITY_INSERT [dbo].[TipoUsuario] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1049, 3, N'matheusatualizado@gmail.com', N'gircC8NsXfWjgGKBw1LzfgwiQ8uxWUIeTlWKw3mVUNvIKeJf', CAST(N'2020-09-20T15:14:58.767' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1050, 2, N'luanati@consultoria.com', N'Mb2AQvj1Vsfxe2c9aGUUSJE5bnyJ6oXhoCDWovLOGjHCca7R', CAST(N'2020-09-22T16:00:19.713' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1052, 2, N'instagram@webrede.com.br', N'RV5zGJN3YW8jizthYVLl5PQkA6VZdwBhduKuwmLF6E8weVs6', CAST(N'2020-10-29T22:53:18.947' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1053, 1, N'adminstrador@gmail.com', N'Kckmxh1M/xsnTSRzokE7T4uPT0xuiDuC3a7hwPJlzJQxZ0+u', CAST(N'2020-11-04T15:44:54.610' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1075, 3, N'matheus.nasci2002@hotmail.com', N'xHjIj8WptfL0Pp95Fd+LlYniIjyVMk1TitWl9dh2SBJmBeBb', CAST(N'2020-11-06T13:08:09.533' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1078, 2, N'facebook@gmail.com', N'7I/yUoHHYKnX0XEdyfux8qhhpy6KUptG2Ym7+XiobNzwXU/I', CAST(N'2020-11-06T13:39:35.647' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1090, 2, N'empresa13@gmail.com', N'BEq3SbAad9d6G2ahL4mrgofYYRmkSgVw3/LrPDYDEOwcX+lH', CAST(N'2020-11-09T14:02:35.773' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1092, 2, N'empresa@gmail.com', N'fmbq2z4JeL2uDglMJ9s2K42uYn+0X8DB07Nz2d8caH8a6sgk', CAST(N'2020-11-10T11:18:25.863' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (1094, 2, N'space@gmail.com', N'1LDQhtwNIY2r8o226dWr5I61OyL+oJ/voDNKWpyZPPnp/X7b', CAST(N'2020-11-24T15:06:21.650' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (2094, 2, N'teste@gmail.com', N'vkTIhX56pARuPHidCu8Cdnh/J8e4rxrRot0WFrSXNnY8ob1N', CAST(N'2020-11-26T17:36:55.380' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (2102, 2, N'emailteste@gmail.com', N'T1dMmgXUxjHcOFAvmNk23vvkvup3+zaazMvMH5gqfSKo4HOe', CAST(N'2020-12-02T12:00:51.003' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (2116, 3, N'marina@gmail.com', N'JRjC6tWZ+c/A+r6OocieLcMcyAaXWwtEWcG0q6197apikQZQ', CAST(N'2020-12-02T17:13:01.060' AS DateTime))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoUsuario], [Email], [Senha], [DataCadastrado]) VALUES (2139, 3, N'muriloluiz20033@gmail.com', N'otsRARYwLqF0Ln63wY0SRe+EYON7iMx2WdwHKRnE5xoP5pZ+', CAST(N'2020-12-15T14:19:06.640' AS DateTime))
SET IDENTITY_INSERT [dbo].[Usuario] OFF
SET IDENTITY_INSERT [dbo].[Vaga] ON 

INSERT [dbo].[Vaga] ([IdVaga], [IdEmpresa], [IdEndereco], [Titulo], [Salario], [Qualificacao], [DataCriado], [DataExpiracao], [CargaHoraria], [Descricao], [Visualizacao]) VALUES (26, 1050, 38, N'Desenvolvedor C++', CAST(1600 AS Decimal(18, 0)), N'Programador Jr', CAST(N'2020-11-04T00:00:00.000' AS DateTime), CAST(N'2020-11-11T00:00:00.000' AS DateTime), 7, N'Conhecer sobre GCC e Linux para desenvolver sistemas', 423)
INSERT [dbo].[Vaga] ([IdVaga], [IdEmpresa], [IdEndereco], [Titulo], [Salario], [Qualificacao], [DataCriado], [DataExpiracao], [CargaHoraria], [Descricao], [Visualizacao]) VALUES (28, 1050, 68, N'Desenvolvedor Java', CAST(3000 AS Decimal(18, 0)), N'Programador Jr', CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-11T00:00:00.000' AS DateTime), 7, N'Desenvolvedor de Java', 82)
INSERT [dbo].[Vaga] ([IdVaga], [IdEmpresa], [IdEndereco], [Titulo], [Salario], [Qualificacao], [DataCriado], [DataExpiracao], [CargaHoraria], [Descricao], [Visualizacao]) VALUES (29, 1050, 70, N'Desenvolvedor C', CAST(3000 AS Decimal(18, 0)), N'Programador Jr', CAST(N'2020-11-09T00:00:00.000' AS DateTime), CAST(N'2020-11-11T00:00:00.000' AS DateTime), 8, N'Desenvolvimento de sistemas com C ', 8)
INSERT [dbo].[Vaga] ([IdVaga], [IdEmpresa], [IdEndereco], [Titulo], [Salario], [Qualificacao], [DataCriado], [DataExpiracao], [CargaHoraria], [Descricao], [Visualizacao]) VALUES (31, 1090, 76, N'Desenvolvedor React Native', CAST(1000 AS Decimal(18, 0)), N'Programador Jr', CAST(N'2020-11-09T00:00:00.000' AS DateTime), CAST(N'2020-11-11T00:00:00.000' AS DateTime), 8, N'Desenvolvedores React Native', 39)
INSERT [dbo].[Vaga] ([IdVaga], [IdEmpresa], [IdEndereco], [Titulo], [Salario], [Qualificacao], [DataCriado], [DataExpiracao], [CargaHoraria], [Descricao], [Visualizacao]) VALUES (1041, 1050, 1170, N'Vaga Teste 4', CAST(1000 AS Decimal(18, 0)), N'Programador Pleno', CAST(N'2020-12-17T00:00:00.000' AS DateTime), CAST(N'2021-11-11T00:00:00.000' AS DateTime), 8, N'Teste', 0)
SET IDENTITY_INSERT [dbo].[Vaga] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Beneficio]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Beneficio] ON [dbo].[Beneficio]
(
	[NomeBeneficio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_CPF]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_CPF] ON [dbo].[Candidato]
(
	[Cpf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Matricula]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Matricula] ON [dbo].[Candidato]
(
	[Matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Rg]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Rg] ON [dbo].[Candidato]
(
	[Rg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Cnpj]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Cnpj] ON [dbo].[Empresa]
(
	[Cnpj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_RazaoSocial]    Script Date: 18/12/2020 16:08:26 ******/
CREATE NONCLUSTERED INDEX [UQ_RazaoSocial] ON [dbo].[Empresa]
(
	[RazaoSocial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Habilida__206452FF4DEB5434]    Script Date: 18/12/2020 16:08:26 ******/
ALTER TABLE [dbo].[Habilidade] ADD  CONSTRAINT [UQ__Habilida__206452FF4DEB5434] UNIQUE NONCLUSTERED 
(
	[NomeHabilidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Email]    Script Date: 18/12/2020 16:08:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Email] ON [dbo].[Usuario]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrador]  WITH CHECK ADD  CONSTRAINT [FK_Administrador_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Administrador] CHECK CONSTRAINT [FK_Administrador_Usuario]
GO
ALTER TABLE [dbo].[Beneficio]  WITH CHECK ADD  CONSTRAINT [FK_Beneficio_Usuario] FOREIGN KEY([IdCriadoPor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Beneficio] CHECK CONSTRAINT [FK_Beneficio_Usuario]
GO
ALTER TABLE [dbo].[BeneficioVaga]  WITH CHECK ADD  CONSTRAINT [FK_BeneficioVaga_Beneficio] FOREIGN KEY([IdBeneficio])
REFERENCES [dbo].[Beneficio] ([IdBeneficio])
GO
ALTER TABLE [dbo].[BeneficioVaga] CHECK CONSTRAINT [FK_BeneficioVaga_Beneficio]
GO
ALTER TABLE [dbo].[BeneficioVaga]  WITH CHECK ADD  CONSTRAINT [FK_BeneficioVaga_Vaga] FOREIGN KEY([IdVaga])
REFERENCES [dbo].[Vaga] ([IdVaga])
GO
ALTER TABLE [dbo].[BeneficioVaga] CHECK CONSTRAINT [FK_BeneficioVaga_Vaga]
GO
ALTER TABLE [dbo].[Candidato]  WITH CHECK ADD  CONSTRAINT [FK_Candidato_Endereco] FOREIGN KEY([IdEndereco])
REFERENCES [dbo].[Endereco] ([IdEndereco])
GO
ALTER TABLE [dbo].[Candidato] CHECK CONSTRAINT [FK_Candidato_Endereco]
GO
ALTER TABLE [dbo].[Candidato]  WITH CHECK ADD  CONSTRAINT [FK_Candidato_StatusUsuario] FOREIGN KEY([IdStatusUsuario])
REFERENCES [dbo].[StatusUsuario] ([IdStatusUsuario])
GO
ALTER TABLE [dbo].[Candidato] CHECK CONSTRAINT [FK_Candidato_StatusUsuario]
GO
ALTER TABLE [dbo].[Candidato]  WITH CHECK ADD  CONSTRAINT [FK_Candidato_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Candidato] CHECK CONSTRAINT [FK_Candidato_Usuario]
GO
ALTER TABLE [dbo].[Candidatura]  WITH CHECK ADD  CONSTRAINT [FK_Candidatura_Candidato] FOREIGN KEY([IdCandidato])
REFERENCES [dbo].[Candidato] ([IdUsuario])
GO
ALTER TABLE [dbo].[Candidatura] CHECK CONSTRAINT [FK_Candidatura_Candidato]
GO
ALTER TABLE [dbo].[Candidatura]  WITH CHECK ADD  CONSTRAINT [FK_Candidatura_Vaga] FOREIGN KEY([IdVaga])
REFERENCES [dbo].[Vaga] ([IdVaga])
GO
ALTER TABLE [dbo].[Candidatura] CHECK CONSTRAINT [FK_Candidatura_Vaga]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Endereco] FOREIGN KEY([IdEndereco])
REFERENCES [dbo].[Endereco] ([IdEndereco])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Endereco]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_StatusUsuario] FOREIGN KEY([IdStatusUsuario])
REFERENCES [dbo].[StatusUsuario] ([IdStatusUsuario])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_StatusUsuario]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Usuario]
GO
ALTER TABLE [dbo].[Habilidade]  WITH NOCHECK ADD  CONSTRAINT [FK_Habilidade_Usuario] FOREIGN KEY([IdCriadoPor])
REFERENCES [dbo].[Usuario] ([IdUsuario])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Habilidade] CHECK CONSTRAINT [FK_Habilidade_Usuario]
GO
ALTER TABLE [dbo].[HabilidadeCandidato]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadeCandidato_Candidato] FOREIGN KEY([IdCandidato])
REFERENCES [dbo].[Candidato] ([IdUsuario])
GO
ALTER TABLE [dbo].[HabilidadeCandidato] CHECK CONSTRAINT [FK_HabilidadeCandidato_Candidato]
GO
ALTER TABLE [dbo].[HabilidadeCandidato]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadeCandidato_Habilidade] FOREIGN KEY([IdHabilidade])
REFERENCES [dbo].[Habilidade] ([IdHabilidade])
GO
ALTER TABLE [dbo].[HabilidadeCandidato] CHECK CONSTRAINT [FK_HabilidadeCandidato_Habilidade]
GO
ALTER TABLE [dbo].[HabilidadeVaga]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadeVaga_Habilidade] FOREIGN KEY([IdHabilidade])
REFERENCES [dbo].[Habilidade] ([IdHabilidade])
GO
ALTER TABLE [dbo].[HabilidadeVaga] CHECK CONSTRAINT [FK_HabilidadeVaga_Habilidade]
GO
ALTER TABLE [dbo].[HabilidadeVaga]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadeVaga_Vaga] FOREIGN KEY([IdVaga])
REFERENCES [dbo].[Vaga] ([IdVaga])
GO
ALTER TABLE [dbo].[HabilidadeVaga] CHECK CONSTRAINT [FK_HabilidadeVaga_Vaga]
GO
ALTER TABLE [dbo].[Matching]  WITH CHECK ADD  CONSTRAINT [FK_Matching_Candidato] FOREIGN KEY([idCandidato])
REFERENCES [dbo].[Candidato] ([IdUsuario])
GO
ALTER TABLE [dbo].[Matching] CHECK CONSTRAINT [FK_Matching_Candidato]
GO
ALTER TABLE [dbo].[Matching]  WITH CHECK ADD  CONSTRAINT [FK_Matching_Vaga] FOREIGN KEY([IdVaga])
REFERENCES [dbo].[Vaga] ([IdVaga])
GO
ALTER TABLE [dbo].[Matching] CHECK CONSTRAINT [FK_Matching_Vaga]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_TipoUsuario] FOREIGN KEY([IdTipoUsuario])
REFERENCES [dbo].[TipoUsuario] ([IdTipoUsuario])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_TipoUsuario]
GO
ALTER TABLE [dbo].[Vaga]  WITH CHECK ADD  CONSTRAINT [FK_Vaga_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdUsuario])
GO
ALTER TABLE [dbo].[Vaga] CHECK CONSTRAINT [FK_Vaga_Empresa]
GO
ALTER TABLE [dbo].[Vaga]  WITH CHECK ADD  CONSTRAINT [FK_Vaga_Endereco] FOREIGN KEY([IdEndereco])
REFERENCES [dbo].[Endereco] ([IdEndereco])
GO
ALTER TABLE [dbo].[Vaga] CHECK CONSTRAINT [FK_Vaga_Endereco]
GO
USE [master]
GO
ALTER DATABASE [ConexaoVagas] SET  READ_WRITE 
GO
