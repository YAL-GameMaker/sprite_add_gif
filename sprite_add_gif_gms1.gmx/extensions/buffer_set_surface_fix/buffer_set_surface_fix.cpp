#pragma once
#include "stdafx.h"
#define gml_ext_h
#include <vector>
#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#include <optional>
#endif
#include <stdint.h>
#include <cstring>
#include <tuple>
using namespace std;

#define dllg /* tag */
#define dllgm /* tag;mangled */

#if defined(_WINDOWS)
#define dllx extern "C" __declspec(dllexport)
#define dllm __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#define dllm __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#define dllm /* */
#endif

#ifdef _WINDEF_
/// auto-generates a window_handle() on GML side
typedef HWND GAME_HWND;
#endif

/// auto-generates an asset_get_index("argument_name") on GML side
typedef int gml_asset_index_of;
/// Wraps a C++ pointer for GML.
template <typename T> using gml_ptr = T*;
/// Same as gml_ptr, but replaces the GML-side pointer by a nullptr after passing it to C++
template <typename T> using gml_ptr_destroy = T*;
/// Wraps any ID (or anything that casts to int64, really) for GML.
template <typename T> using gml_id = T;
/// Same as gml_id, but replaces the GML-side ID by a 0 after passing it to C++
template <typename T> using gml_id_destroy = T;

class gml_buffer {
private:
	uint8_t* _data;
	int32_t _size;
	int32_t _tell;
public:
	gml_buffer() : _data(nullptr), _tell(0), _size(0) {}
	gml_buffer(uint8_t* data, int32_t size, int32_t tell) : _data(data), _size(size), _tell(tell) {}

	inline uint8_t* data() { return _data; }
	inline int32_t tell() { return _tell; }
	inline int32_t size() { return _size; }
};

class gml_istream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_istream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> T read() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		T result{};
		std::memcpy(&result, pos, sizeof(T));
		pos += sizeof(T);
		return result;
	}

	char* read_string() {
		char* r = (char*)pos;
		while (*pos != 0) pos++;
		pos++;
		return r;
	}

	template<class T> std::vector<T> read_vector() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		auto n = read<uint32_t>();
		std::vector<T> vec(n);
		std::memcpy(vec.data(), pos, sizeof(T) * n);
		pos += sizeof(T) * n;
		return vec;
	}
	#ifdef tiny_array_h
	template<class T> tiny_const_array<T> read_tiny_const_array() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		auto n = read<uint32_t>();
		tiny_const_array<T> arr((T*)pos, sizeof(T));
		pos += sizeof(T) * n;
		return arr;
	}
	#endif
	
	std::vector<const char*> read_string_vector() {
		auto n = read<uint32_t>();
		std::vector<const char*> vec(n);
		for (auto i = 0u; i < n; i++) {
			vec[i] = read_string();
		}
		return vec;
	}

	gml_buffer read_gml_buffer() {
		auto _data = (uint8_t*)read<int64_t>();
		auto _size = read<int32_t>();
		auto _tell = read<int32_t>();
		return gml_buffer(_data, _size, _tell);
	}

	#ifdef tiny_optional_h
	template<class T> tiny_optional<T> read_tiny_optional() {
		if (read<bool>()) {
			return read<T>;
		} else return {};
	}
	#endif

	#pragma region Tuples
	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	std::tuple<Args...> read_tuple() {
		std::tuple<Args...> tup;
		std::apply([this](auto&&... arg) {
			((
				arg = this->read<std::remove_reference_t<decltype(arg)>>()
				), ...);
			}, tup);
		return tup;
	}

	template<class T> optional<T> read_optional() {
		if (read<bool>()) {
			return read<T>;
		} else return {};
	}
	#else
	template<class A, class B> std::tuple<A, B> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		return std::tuple<A, B>(a, b);
	}

	template<class A, class B, class C> std::tuple<A, B, C> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		return std::tuple<A, B, C>(a, b, c);
	}

	template<class A, class B, class C, class D> std::tuple<A, B, C, D> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		D d = read<d>();
		return std::tuple<A, B, C, D>(a, b, c, d);
	}
	#endif
};

class gml_ostream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_ostream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> void write(T val) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		memcpy(pos, &val, sizeof(T));
		pos += sizeof(T);
	}

	void write_string(const char* s) {
		for (int i = 0; s[i] != 0; i++) write<char>(s[i]);
		write<char>(0);
	}

	template<class T> void write_vector(std::vector<T>& vec) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		auto n = vec.size();
		write<uint32_t>((uint32_t)n);
		memcpy(pos, vec.data(), n * sizeof(T));
		pos += n * sizeof(T);
	}

	#ifdef tiny_array_h
	template<class T> void write_tiny_array(tiny_array<T>& arr) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		auto n = arr.size();
		write<uint32_t>(n);
		memcpy(pos, arr.data(), n * sizeof(T));
		pos += n * sizeof(T);
	}
	template<class T> void write_tiny_const_array(tiny_const_array<T>& arr) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		auto n = arr.size();
		write<uint32_t>(n);
		memcpy(pos, arr.data(), n * sizeof(T));
		pos += n * sizeof(T);
	}
	#endif
	
	void write_string_vector(std::vector<const char*> vec) {
		auto n = vec.size();
		write<uint32_t>((uint32_t)n);
		for (auto i = 0u; i < n; i++) {
			write_string(vec[i]);
		}
	}

	#ifdef tiny_optional_h
	template<typename T> void write_tiny_optional(tiny_optional<T>& val) {
		auto hasValue = val.has_value();
		write<bool>(hasValue);
		if (hasValue) write<T>(val.value());
	}
	#endif

	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	void write_tuple(std::tuple<Args...> tup) {
		std::apply([this](auto&&... arg) {
			(this->write(arg), ...);
			}, tup);
	}

	template<class T> void write_optional(optional<T>& val) {
		auto hasValue = val.has_value();
		write<bool>(hasValue);
		if (hasValue) write<T>(val.value());
	}
	#else
	template<class A, class B> void write_tuple(std::tuple<A, B>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
	}
	template<class A, class B, class C> void write_tuple(std::tuple<A, B, C>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
	}
	template<class A, class B, class C, class D> void write_tuple(std::tuple<A, B, C, D>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
		write<D>(std::get<3>(tup));
	}
	#endif
};
//{{NO_DEPENDENCIES}}
// Microsoft Visual C++ generated include file.
// Used by buffer_set_surface_fix.rc

// Next default values for new objects
// 
#ifdef APSTUDIO_INVOKED
#ifndef APSTUDIO_READONLY_SYMBOLS
#define _APS_NEXT_RESOURCE_VALUE        101
#define _APS_NEXT_COMMAND_VALUE         40001
#define _APS_NEXT_CONTROL_VALUE         1001
#define _APS_NEXT_SYMED_VALUE           101
#endif
#endif
// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#pragma region configuration

#define _trace // requires user32.lib;Kernel32.lib

#ifdef TINY // common things to implement
//#define tiny_memset
//#define tiny_memcpy
//#define tiny_malloc // malloc, realloc, free
//#define tiny_new // new, new[], delete, delete[] - requires tiny_malloc
//#define tiny_init_cleanup // static init, cleanup, atexit
//#define tiny_dtoui3
#endif

#pragma endregion

#ifdef _WINDOWS
	#include "targetver.h"
	
	#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers
	#include <windows.h>
#endif

#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#define tiny_cpp17
#endif

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

void tiny_init();
void tiny_cleanup();

#ifdef _trace
static constexpr char trace_prefix[] = "[buffer_set_surface_fix] ";
#ifdef TINY
void trace(const char* format, ...);
#else
#define trace(...) { printf("%s", trace_prefix); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#endif
#endif

#pragma region typed memory helpers
template<typename T> T* malloc_arr(size_t count) {
	return (T*)malloc(sizeof(T) * count);
}
template<typename T> T* realloc_arr(T* arr, size_t count) {
	return (T*)realloc(arr, sizeof(T) * count);
}
template<typename T> T* memcpy_arr(T* dst, const T* src, size_t count) {
	return (T*)memcpy(dst, src, sizeof(T) * count);
}
#pragma endregion

#include "gml_ext.h"

// TODO: reference additional headers your program requires here
#pragma once

// Including SDKDDKVer.h defines the highest available Windows platform.

// If you wish to build your application for a previous Windows platform, include WinSDKVer.h and
// set the _WIN32_WINNT macro to the platform you wish to support before including SDKDDKVer.h.

#include <SDKDDKVer.h>
#pragma once
#include "stdafx.h"

template<typename T> class tiny_array {
	T* _data;
	size_t _size;
	size_t _capacity;

	bool add_impl(T value) {
		if (_size >= _capacity) {
			auto new_capacity = _capacity * 2;
			auto new_data = realloc_arr(_data, _capacity);
			if (new_data == nullptr) {
				trace("Failed to reallocate %u bytes in tiny_array::add", sizeof(T) * new_capacity);
				return false;
			}
			for (size_t i = _capacity; i < new_capacity; i++) new_data[i] = {};
			_data = new_data;
			_capacity = new_capacity;
		}
		_data[_size++] = value;
		return true;
	}
public:
	tiny_array() { }
	tiny_array(size_t capacity) { init(capacity); }
	inline void init(size_t capacity = 4) {
		if (capacity < 1) capacity = 1;
		_size = 0;
		_capacity = capacity;
		_data = malloc_arr<T>(capacity);
	}
	inline void free() {
		if (_data) {
			::free(_data);
			_data = nullptr;
		}
	}

	size_t size() { return _size; }
	size_t capacity() { return _capacity; }
	T* data() { return _data; }

	bool resize(size_t newsize, T value = {}) {
		if (newsize > _capacity) {
			auto new_data = realloc_arr(_data, newsize);
			if (new_data == nullptr) {
				trace("Failed to reallocate %u bytes in tiny_array::resize", sizeof(T) * newsize);
				return false;
			}
			_data = new_data;
			_capacity = newsize;
		}
		for (size_t i = _size; i < newsize; i++) _data[i] = value;
		for (size_t i = _size; --i >= newsize;) _data[i] = value;
		_size = newsize;
		return true;
	}

	#ifdef tiny_cpp17
	template<class... Args>
	inline bool add(Args... values) {
		return (add_impl(values) && ...);
	}
	#else
	inline void add(T value) {
		add_impl(value);
	}
	#endif

	bool remove(size_t index, size_t count = 1) {
		size_t end = index + count;
		if (end < _size) memcpy_arr(_data + start, _data + end, _size - end);
		_size -= end - index;
		return true;
	}

	bool set(T* values, size_t count) {
		if (!resize(count)) return false;
		memcpy_arr(_data, values, count);
		return true;
	}
	template<size_t count> inline bool set(T(&values)[count]) {
		return set(values, count);
	}

	T operator[] (size_t index) const { return _data[index]; }
	T& operator[] (size_t index) { return _data[index]; }
};#include "gml_ext.h"
/// @author YellowAfterlife

#include "stdafx.h"
enum RValueType : int32_t {
	Real = 0,
	Int32 = 7,
	Int64 = 10,
	Bool = 13,
};
struct RValue {
	union {
		int32_t v32;
		int64_t v64;
		double real;
		void* ptr;
	};
	int32_t flags = 0;
	RValueType type = Real;
	RValue() { real = 0; }
	RValue(double val) { real = val; }
};
typedef void(*GMLFunc)(RValue& result, void* self, void* other, int argc, RValue* args);
struct GMLClosure {
	int __mysteries[26];
	GMLFunc call;
};

static int sprite_id;
static GMLClosure* draw_sprite_stretched_ext;
struct BGRA {
	uint8_t blue;
	uint8_t green;
	uint8_t red;
	uint8_t alpha;
	inline uint32_t asU32() {
		return *(uint32_t*)this;
	}
};

dllx void buffer_set_surface_fallback_init(void* ptr, double spr) {
	draw_sprite_stretched_ext = (GMLClosure*)ptr;
	sprite_id = (int)spr;
}
dllx void buffer_set_surface_fallback(uint8_t* _data, double _width, double _height, double _offset) {
	if (draw_sprite_stretched_ext == nullptr) return;
	static_assert(sizeof(BGRA) == 4);
	_data += (ptrdiff_t)_offset;
	auto bgra = (BGRA*)_data;
	auto width = (int)_width;
	auto height = (int)_height;
	RValue result;
	RValue args[] = { (double)sprite_id, 0, 0, 0, 1, 1, -1, 1 };
	auto func = draw_sprite_stretched_ext->call;
	for (int y = 0; y < height; y++) {
		auto row = bgra + width * y;
		int x = 0;
		args[3].real = y;
		while (x < width) {
			auto col = row[x++];
			if (col.alpha == 0) continue;
			std::swap(col.red, col.blue);
			args[2].real = x - 1;
			auto count = 1;
			while (x < width) {
				if (row[x].asU32() == col.asU32()) {
					count += 1;
					x += 1;
				} else break;
			}
			args[4].real = count;
			args[7].real = (double)col.alpha / 255.;
			col.alpha = 0;
			args[6].real = col.asU32();
			func(result, 0, 0, 8, args);
		}
	}
}

static inline void init() {
	sprite_id = -1;
	draw_sprite_stretched_ext = nullptr;
}
BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved) {
	if (ul_reason_for_call == DLL_PROCESS_ATTACH) init();
	return TRUE;
}
#include "stdafx.h"

/**
    Implements the absolute bare minimum for static init, cleanup, and and atexit()
    https://learn.microsoft.com/en-us/cpp/c-runtime-library/crt-initialization?view=msvc-170
    https://gist.github.com/vaualbus/622099d88334fbba1d4ae703642c2956
**/
#if defined(TINY) && defined(tiny_init_cleanup)

#pragma section(".CRT$XIA", long, read) // First C Initializer
#pragma section(".CRT$XIZ", long, read) // Last C Initializer
#pragma section(".CRT$XCA", long, read) // First C++ Initializer
#pragma section(".CRT$XCZ", long, read) // Last C++ Initializer
#pragma section(".CRT$XPA", long, read) // First Pre-Terminator
#pragma section(".CRT$XPZ", long, read) // Last Pre-Terminator
#pragma section(".CRT$XTA", long, read) // First Terminator
#pragma section(".CRT$XTZ", long, read) // Last Terminator

#pragma comment(linker, "/merge:.CRT=.rdata")

#define _CRTALLOC(x) __declspec(allocate(x))
typedef int(__cdecl* _PIFV)(void);
typedef void(__cdecl* _PVFV)(void);

extern "C" {
    _CRTALLOC(".CRT$XIA") _PIFV __xi_a[] = { nullptr }; // C initializers (first)
    _CRTALLOC(".CRT$XIZ") _PIFV __xi_z[] = { nullptr }; // C initializers (last)
    _CRTALLOC(".CRT$XCA") _PVFV __xc_a[] = { nullptr }; // C++ initializers (first)
    _CRTALLOC(".CRT$XCZ") _PVFV __xc_z[] = { nullptr }; // C++ initializers (last)
    _CRTALLOC(".CRT$XPA") _PVFV __xp_a[] = { nullptr }; // C pre-terminators (first)
    _CRTALLOC(".CRT$XPZ") _PVFV __xp_z[] = { nullptr }; // C pre-terminators (last)
    _CRTALLOC(".CRT$XTA") _PVFV __xt_a[] = { nullptr }; // C terminators (first)
    _CRTALLOC(".CRT$XTZ") _PVFV __xt_z[] = { nullptr }; // C terminators (last)

    int __cdecl _initterm_e(_PIFV* first, _PIFV* last) {
        for (_PIFV* it = first; it != last; ++it) {
            if (*it == nullptr) continue;

            int const result = (**it)();
            if (result != 0) return result;
        }
        return 0;
    }

    void __cdecl _initterm(_PVFV* first, _PVFV* last) {
        for (_PVFV* it = first; it != last; ++it) {
            if (*it != nullptr) {
                (**it)();
            }
        }
    }

    struct {
        _PVFV* items = nullptr;
        size_t size = 0;
        size_t capacity = 0;
    } static exitList;

    int __cdecl atexit(_PVFV func) {
        auto capacity = exitList.capacity;
        if (exitList.size >= capacity) {
            if (capacity) capacity *= 2; else capacity = 4;
            _PVFV* new_data = realloc_arr(exitList.items, capacity);
            if (new_data == nullptr) return -1;
            exitList.items = new_data;
            exitList.capacity = capacity;
        }
        exitList.items[exitList.size++] = func;
        return 0;
    }
}

void tiny_init() {
    _initterm_e(__xi_a, __xi_z);
    _initterm(__xc_a, __xc_z);
}

void tiny_cleanup() {
    if (exitList.size) {
        auto i = exitList.size;
        do {
            auto fn = exitList.items[--i];
            fn();
        } while (i != 0);
        exitList.size = 0;
        exitList.capacity = 0;
        HeapFree(GetProcessHeap(), 0, exitList.items);
        exitList.items = nullptr;
    }

    _initterm(__xp_a, __xp_z);
    _initterm(__xt_a, __xt_z);
}

#else
void tiny_init() {}
void tiny_cleanup() {}
#endif#include "stdafx.h"

#if defined(TINY) && defined(tiny_malloc)

#pragma warning(disable: 28251 28252)
void* __cdecl malloc(size_t _Size) {
	auto result = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, _Size);
	return result;
}
void* __cdecl realloc(void* _Block, size_t _Size) {
	auto heap = GetProcessHeap();
	void* result;
	if (_Block == nullptr) {
		// unlike the CRT realloc, HeapReAlloc won't Alloc if a block is NULL
		result = HeapAlloc(heap, HEAP_ZERO_MEMORY, _Size);
	} else {
		result = HeapReAlloc(heap, HEAP_ZERO_MEMORY, _Block, _Size);
	}
	return result;
}
void __cdecl free(void* _Block) {
	HeapFree(GetProcessHeap(), 0, _Block);
}

#ifdef tiny_new
void* operator new(size_t _Size) {
	return malloc(_Size);
}
void* operator new[](size_t _Size) {
	return malloc(_Size);
}

void operator delete(void* _Block) {
	free(_Block);
}
void operator delete(void* _Block, size_t _Size) {
	free(_Block);
}
void operator delete[](void* _Block) {
	free(_Block);
}
void operator delete[](void* _Block, size_t _Size) {
	free(_Block);
}
#endif

#pragma warning(default: 28251 28252)

#endif
#include "stdafx.h"

/**
	Note: you might have to disable "Whole-program optimization" (/GL) for this file in MSVC
**/
#if defined(TINY)
#include <stdint.h>
#include <intrin.h>

#pragma warning(disable: 28251 28252 6001)

#ifdef tiny_memset
#pragma function(memset)
void* __cdecl memset(void* _Dst, _In_ int _Val, _In_ size_t _Size) {
	#ifdef _MSC_VER
	__stosb(static_cast<uint8_t*>(_Dst), static_cast<uint8_t>(_Val), _Size);
	#else
	auto ptr = static_cast<uint8_t*>(_Dst);
	while (_Size) {
		*ptr++ = _Val;
		_Size--;
	}
	#endif
	return _Dst;
}
#endif

#ifdef tiny_memcpy
#pragma function(memcpy)
void* memcpy(void* _Dst, const void* _Src, size_t _Size) {
	// NB! Doesn't handle overlaps between source and destination block.
	#ifdef _MSC_VER
	__movsb(static_cast<uint8_t*>(_Dst), static_cast<const uint8_t*>(_Src), _Size);
	#else
	auto src8 = static_cast<const uint64_t*>(_Src);
	auto dst8 = static_cast<uint64_t*>(_Dst);
	for (; _Size > 32; _Size -= 32) {
		*dst8++ = *src8++;
		*dst8++ = *src8++;
		*dst8++ = *src8++;
		*dst8++ = *src8++;
	}
	for (; _Size > 8; _Size -= 8) *dst8++ = *src8++;
	//
	auto src1 = (const uint8_t*)(src8);
	auto dst1 = (uint8_t*)(dst8);
	for (; _Size != 0; _Size--) *dst1++ = *src1++;
	#endif
	return _Dst;
}
#endif

#pragma warning(default: 28251 28252 6001)

#endif
#include "stdafx.h"

#ifdef TINY

#ifdef tiny_dtoui3
#include <intrin.h>
#endif

// http://computer-programming-forum.com/7-vc.net/07649664cea3e3d7.htm
extern "C" int _fltused = 0;

#ifdef tiny_dtoui3
// https:/stackoverflow.com/a/55011686/5578773
extern "C" unsigned int _dtoui3(const double x) {
	return (unsigned int)_mm_cvttsd_si32(_mm_set_sd(x));
}
#endif

#endif
#include "stdafx.h"

#if defined(TINY) && defined(_trace)
// https://yal.cc/printf-without-standard-library/
void trace(const char* pszFormat, ...) {
	char buf[1024 + sizeof(trace_prefix)];
	wsprintfA(buf, "%s", trace_prefix);
	va_list argList;
	va_start(argList, pszFormat);
	wvsprintfA(buf + sizeof(trace_prefix) - 1, pszFormat, argList);
	va_end(argList);
	DWORD done;
	auto len = strlen(buf);
	buf[len] = '\n';
	buf[++len] = 0;
	WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), buf, (DWORD)len, &done, NULL);
}
#endif
