module dfftw3.fftw3;

import std.array;
public import std.complex;

extern(C)
{
	enum fftw_r2r_kind_do_not_use_me
	{
		FFTW_R2HC=0,
		FFTW_HC2R=1,
		FFTW_DHT=2,
		FFTW_REDFT00=3,
		FFTW_REDFT01=4,
		FFTW_REDFT10=5,
		FFTW_REDFT11=6,
		FFTW_RODFT00=7,
		FFTW_RODFT01=8,
		FFTW_RODFT10=9,
		FFTW_RODFT11=10
	}

	struct fftw_iodim_do_not_use_me
	{
		int n;
		int _is;
		int os;
	}

	struct fftw_iodim64_do_not_use_me
	{
		ptrdiff_t n;
		ptrdiff_t _is;
		ptrdiff_t os;
	}
}

alias fftw_write_char_func_do_not_use_me = extern (C) void function(char c, void *);
alias fftw_read_char_func_do_not_use_me = extern (C) int function(void *);

private
{
	string createAlias(string prefix, string newIdent, string oldIdent)
	{
		return "alias " ~ prefix ~ newIdent ~ " = " ~ oldIdent ~ ";";
	}

	string createFunction(string prefix, string funcName, string retType, string[] params)
	{
		return retType ~ " " ~ prefix ~ funcName ~ "(" ~ join(params, ", ") ~ ");";
	}

	auto createApi(string prefix, string realType, string complexType)
	{
		string complexPtrType = complexType ~ " *";
		string realPtrType = realType ~ " *";
		string planType = prefix ~ "plan";
		string iodimPtrType = prefix ~ "iodim *";
		string iodim64PtrType = prefix ~ "iodim64 *";

		return join([
			
			createAlias(prefix, "plan", "void *"),
			
			createAlias(prefix, "iodim", "fftw_iodim_do_not_use_me"),
			createAlias(prefix, "iodim64", "fftw_iodim64_do_not_use_me"),
			
			createAlias(prefix, "r2r_kind", "fftw_r2r_kind_do_not_use_me"),
			
			createAlias(prefix, "write_char_func", "fftw_write_char_func_do_not_use_me"),
			createAlias(prefix, "read_char_func", "fftw_read_char_func_do_not_use_me"),
			
			createFunction(prefix, "execute", "void", ["const " ~ planType]),

			createFunction(prefix, "plan_dft", planType, [
				"int",
				"const int *",
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_dft_1d", planType, [
				"int",
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),
			createFunction(prefix, "plan_dft_2d", planType, [
				"int",
				"int",
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),
			createFunction(prefix, "plan_dft_3d", planType, [
				"int",
				"int",
				"int",
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_many_dft", planType, [
				"int",
				"const int *",
				"int",
				complexPtrType,
				"const int *",
				"int",
				"int",
				complexPtrType,
				"const int *",
				"int",
				"int",
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_guru_dft", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~ iodimPtrType,
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),
			createFunction(prefix, "plan_guru_split_dft", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~ iodimPtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_guru64_dft", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~ iodim64PtrType,
				complexPtrType,
				complexPtrType,
				"int",
				"uint"
			]),
			createFunction(prefix, "plan_guru64_split_dft", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~ iodim64PtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"int",
				"uint"
			]),

			createFunction(prefix, "execute_dft", "void", [
				"const " ~ planType,
				complexPtrType,
				complexPtrType
			]),
			createFunction(prefix, "execute_split_dft", "void", [
				"const " ~ planType,
				realPtrType,
				realPtrType,
				realPtrType,
				realPtrType
			]),

			createFunction(prefix, "plan_many_dft_r2c", planType, [
				"int",
				"const int *",
				"int",
				realPtrType,
				"const int *",
				"int",
				"int",
				complexPtrType,
				"const int *",
				"int",
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_dft_r2c", planType, [
				"int",
				"const int *",
				realPtrType,
				complexPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_dft_r2c_1d", planType, [
				"int",
				realPtrType,
				complexPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_dft_r2c_2d", planType, [
				"int",
				"int",
				realPtrType,
				complexPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_dft_r2c_3d", planType, [
				"int",
				"int",
				"int",
				realPtrType,
				complexPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_many_dft_c2r", planType, [
				"int",
				"const int *",
				"int",
				complexPtrType,
				"const int *",
				"int",
				"int",
				realPtrType,
				"const int *",
				"int",
				"int",
				"uint"
			]),

			createFunction(prefix, "plan_dft_c2r", planType, [
				"int",
				"const int *",
				complexPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_dft_c2r_1d", planType, [
				"int",
				complexPtrType,
				realPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_dft_c2r_2d", planType, [
				"int",
				"int",
				complexPtrType,
				realPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_dft_c2r_3d", planType, [
				"int",
				"int",
				"int",
				complexPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_guru_dft_r2c", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~ iodimPtrType,
				realPtrType,
				complexPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_guru_dft_c2r", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~ iodimPtrType,
				complexPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_guru_split_dft_r2c", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~  iodimPtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_guru_split_dft_c2r", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~  iodimPtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_guru64_dft_r2c", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~ iodim64PtrType,
				realPtrType,
				complexPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_guru64_dft_c2r", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~ iodim64PtrType,
				complexPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "plan_guru64_split_dft_r2c", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~  iodim64PtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"uint"
			]),
			createFunction(prefix, "plan_guru64_split_dft_c2r", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~  iodim64PtrType,
				realPtrType,
				realPtrType,
				realPtrType,
				"uint"
			]),

			createFunction(prefix, "execute_dft_r2c", "void", [
				"const " ~ planType,
				realPtrType,
				complexPtrType
			]),
			createFunction(prefix, "execute_dft_c2r", "void", [
				"const " ~ planType,
				complexPtrType,
				realPtrType
			]),

			createFunction(prefix, "execute_split_dft_r2c", "void", [
				"const " ~ planType,
				realPtrType,
				realPtrType,
				realPtrType
			]),
			createFunction(prefix, "execute_split_dft_c2r", "void", [
				"const " ~ planType,
				realPtrType,
				realPtrType,
				realPtrType
			]),

			createFunction(prefix, "plan_many_r2r", planType, [
				"int",
				"const int *",
				"int",
				realPtrType,
				"const int *",
				"int",
				"int",
				realPtrType,
				"const int *",
				"int",
				"int",
				"const " ~ prefix ~ "r2r_kind *",
				"uint"
			]),
			
			createFunction(prefix, "plan_r2r", planType, [
				"int",
				"const int *",
				realPtrType,
				realPtrType,
				"const " ~ prefix ~ "r2r_kind *",
				"uint"
			]),

			createFunction(prefix, "plan_r2r_1d", planType, [
				"int",
				realPtrType,
				realPtrType,
				prefix ~ "r2r_kind",
				"uint"
			]),
			createFunction(prefix, "plan_r2r_2d", planType, [
				"int",
				"int",
				realPtrType,
				realPtrType,
				prefix ~ "r2r_kind",
				"uint"
			]),
			createFunction(prefix, "plan_r2r_3d", planType, [
				"int",
				"int",
				"int",
				realPtrType,
				realPtrType,
				prefix ~ "r2r_kind",
				"uint"
			]),

			createFunction(prefix, "plan_guru_r2r", planType, [
				"int",
				"const " ~ iodimPtrType,
				"int",
				"const " ~ iodimPtrType,
				realPtrType,
				realPtrType,
				"const " ~ prefix ~ "r2r_kind *",
				"uint"
			]),

			createFunction(prefix, "plan_guru64_r2r", planType, [
				"int",
				"const " ~ iodim64PtrType,
				"int",
				"const " ~ iodim64PtrType,
				realPtrType,
				realPtrType,
				"const " ~ prefix ~ "r2r_kind *",
				"uint"
			]),

			createFunction(prefix, "execute_r2r", "void", [
				"const " ~ planType,
				realPtrType,
				realPtrType
			]),

			createFunction(prefix, "destroy_plan", "void", [
				planType
			]),
			createFunction(prefix, "forget_wisdom", "void", [
			]),
			createFunction(prefix, "cleanup", "void", [
			]),

			createFunction(prefix, "set_timelimit", "void", [
				"double"
			]),

			createFunction(prefix, "plan_with_nthreads", "void", [
				"int"
			]),
			createFunction(prefix, "init_threads", "int", [
			]),
			createFunction(prefix, "cleanup_threads", "void", [
			]),

			createFunction(prefix, "export_wisdom_to_filename", "int", [
				"const char *"
			]),
			createFunction(prefix, "export_wisdom_to_file", "void", [
				"void *"
			]),
			createFunction(prefix, "export_wisdom_to_string", "char *", [
			]),
			createFunction(prefix, "export_wisdom", "void", [
				prefix ~ "write_char_func",
				"void *"
			]),
			createFunction(prefix, "import_system_wisdom", "int", [
			]),
			createFunction(prefix, "import_wisdom_from_filename", "int", [
				"const char *"
			]),
			createFunction(prefix, "import_wisdom_from_file", "int", [
				"void *"
			]),
			createFunction(prefix, "import_wisdom_from_string", "int", [
				"const char *"
			]),
			createFunction(prefix, "import_wisdom", "int", [
				prefix ~ "read_char_func",
				"void *"
			]),

			createFunction(prefix, "fprint_plan", "void", [
				"const " ~ planType,
				"void *"
			]),
			createFunction(prefix, "print_plan", "void", [
				"const " ~ planType
			]),
			createFunction(prefix, "sprint_plan", "char *", [
				"const " ~ planType
			]),

			createFunction(prefix, "malloc", "void *", [
				"size_t"
			]),
			createFunction(prefix, "alloc_real", realPtrType, [
				"size_t"
			]),
			createFunction(prefix, "alloc_complex", complexPtrType, [
				"size_t"
			]),
			createFunction(prefix, "free", "void", [
				"void *"
			]),

			createFunction(prefix, "flops", "void", [
				"const " ~ planType,
				"double *",
				"double *",
				"double *"
			]),
			createFunction(prefix, "estimate_cost", "double", [
				"const " ~ planType
			]),
			createFunction(prefix, "cost", "double", [
				"const " ~ planType
			]),

			createFunction(prefix, "alignment_of", "int", [
				realPtrType
			])//,
			//"const char *" ~ prefix ~ "version;",
			//"const char *" ~ prefix ~ "cc;",
			//"const char *" ~ prefix ~ "codelet_optim;"

		], "\n");
	}
}

extern(C)
{
	mixin(createApi("fftw_", "double", "Complex!double"));
	mixin(createApi("fftwf_", "float", "Complex!float"));
	mixin(createApi("fftwl_", "real", "Complex!real"));
}

enum FFTW_FORWARD = -1;
enum FFTW_BACKWARD = 1;

enum FFTW_NO_TIMELIMIT = -1.0;

enum FFTW_MEASURE = (0U);
enum FFTW_DESTROY_INPUT = (1U << 0);
enum FFTW_UNALIGNED = (1U << 1);
enum FFTW_CONSERVE_MEMORY = (1U << 2);
enum FFTW_EXHAUSTIVE = (1U << 3);
enum FFTW_PRESERVE_INPUT = (1U << 4);
enum FFTW_PATIENT = (1U << 5);
enum FFTW_ESTIMATE = (1U << 6);
enum FFTW_WISDOM_ONLY = (1U << 21);

enum FFTW_ESTIMATE_PATIENT = (1U << 7);
enum FFTW_BELIEVE_PCOST = (1U << 8);
enum FFTW_NO_DFT_R2HC = (1U << 9);
enum FFTW_NO_NONTHREADED = (1U << 10);
enum FFTW_NO_BUFFERING = (1U << 11);
enum FFTW_NO_INDIRECT_OP = (1U << 12);
enum FFTW_ALLOW_LARGE_GENERIC = (1U << 13);
enum FFTW_NO_RANK_SPLITS = (1U << 14);
enum FFTW_NO_VRANK_SPLITS = (1U << 15);
enum FFTW_NO_VRECURSE = (1U << 16);
enum FFTW_NO_SIMD = (1U << 17);
enum FFTW_NO_SLOW = (1U << 18);
enum FFTW_NO_FIXED_RADIX_LARGE_N = (1U << 19);
enum FFTW_ALLOW_PRUNING = (1U << 20);
