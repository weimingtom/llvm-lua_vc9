@set LLVM_GCC=F:\llvm-gcc4.2-2.7-x86-mingw32\bin\
@set LLVM_BIN=F:\llvm-2.7-x86-mingw32\
@set BIN2C_BIN=.\

@echo generate llvm-lua header files
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/lua_vm_ops.bc ./llvm-lua/lua_vm_ops.c
@"%BIN2C_BIN%\bin2c.exe" -z -c ./generate/lua_vm_ops.bc ./generate/lua_vm_ops_bc.h

@echo generate llvm-luac header files
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/no_jit.c.bc ./llvm-lua/no_jit.c
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/lua_vm_ops_static.c.bc ./llvm-lua/lua_vm_ops_static.c
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/lua_main.c.bc ./llvm-lua/lua_main.c
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/lua_core.c.bc ./llvm-lua/lua_core.c
@"%LLVM_GCC%\llvm-gcc.exe" -DLUA_BUILD_AS_DLL -c -emit-llvm -Isrc -o ./generate/load_jit_proto.c.bc ./llvm-lua/load_jit_proto.c
@"%LLVM_BIN%\llvm-link.exe" -f -o ./generate/liblua_main.bc ./generate/lua_main.c.bc ./generate/no_jit.c.bc ./generate/lua_core.c.bc ./generate/lua_vm_ops_static.c.bc ./generate/load_jit_proto.c.bc
@"%BIN2C_BIN%\bin2c.exe" -z -c ./generate/liblua_main.bc ./generate/liblua_main_bc.h

@pause
