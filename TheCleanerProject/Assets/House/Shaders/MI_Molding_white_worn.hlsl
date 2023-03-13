#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

struct Input
{
	//float3 Normal;
	float2 uv_MainTex : TEXCOORD0;
	float2 uv2_Material_Texture2D_0 : TEXCOORD1;
	float4 color : COLOR;
	float4 tangent;
	//float4 normal;
	float3 viewDir;
	float4 screenPos;
	float3 worldPos;
	//float3 worldNormal;
	float3 normal2;
};
struct SurfaceOutputStandard
{
	float3 Albedo;		// base (diffuse or specular) color
	float3 Normal;		// tangent space normal, if written
	half3 Emission;
	half Metallic;		// 0=non-metal, 1=metal
	// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
	// Everywhere in the code you meet smoothness it is perceptual smoothness
	half Smoothness;	// 0=rough, 1=smooth
	half Occlusion;		// occlusion (default 1)
	float Alpha;		// alpha for transparencies
};

//#define Texture2D sampler2D
//#define TextureCube samplerCUBE
//#define SamplerState int

#define URP 1
#define UE5
//struct Material
//{
	//samplers start
SAMPLER( SamplerState_Linear_Repeat );
SAMPLER( SamplerState_Linear_Clamp );
TEXTURE2D(       Material_Texture2D_0 );
SAMPLER( sampler_Material_Texture2D_0);
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER( sampler_Material_Texture2D_1);
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER( sampler_Material_Texture2D_2);
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER( sampler_Material_Texture2D_3);
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER( sampler_Material_Texture2D_4);
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER( sampler_Material_Texture2D_5);
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER( sampler_Material_Texture2D_6);

//};

#ifdef UE5
	#define UE_LWC_RENDER_TILE_SIZE			2097152.0
	#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
	#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
	#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
	#define INVARIANT(X) X
	#define PI 					(3.1415926535897932)

	#include "LargeWorldCoordinates.hlsl"
#endif
struct MaterialStruct
{
	float4 PreshaderBuffer[828 ];
	float4 ScalarExpressions[11 ];
	float VTPackedPageTableUniform[ 4 ];
};
SamplerState View_MaterialTextureBilinearWrapedSampler;
SamplerState View_MaterialTextureBilinearClampedSampler;
struct ViewStruct
{
	float GameTime;
	float MaterialTextureMipBias;
	float4 PrimitiveSceneData[ 40 ];
	float2 TemporalAAParams;
	float2 ViewRectMin;
	float4 ViewSizeAndInvSize;
	float MaterialTextureDerivativeMultiply;
	uint StateFrameIndexMod8;
};
struct ResolvedViewStruct
{
	#ifdef UE5
		FLWCVector3 WorldCameraOrigin;
	#else
		float3 WorldCameraOrigin;
	#endif
	float4 ScreenPositionScaleBias;
	float4x4 TranslatedWorldToView;
	float4x4 TranslatedWorldToCameraView;
	float4x4 ViewToTranslatedWorld;
	float4x4 CameraViewToTranslatedWorld;
};
struct PrimitiveStruct
{
	float4x4 WorldToLocal;
	float4x4 LocalToWorld;
};

ViewStruct View;
ResolvedViewStruct ResolvedView;
PrimitiveStruct Primitive;
uniform float4 View_BufferSizeAndInvSize;
uniform SamplerState Material_Wrap_WorldGroupSettings;
uniform SamplerState Material_Clamp_WorldGroupSettings;

#include "UnrealCommon.cginc"

MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(0.000000,1.000000,0.309524,0.309524);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.309524,0.619048,-0.380952,2.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(-1.000000,3.047619,0.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(512.000000,512.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(512.000000,512.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(-512.000000,-512.000000,-512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(-0.001953,-0.001953,-0.001953,0.342857);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.342857,0.342857,0.685714,-0.314286);//(Unknown)
	Material.PreshaderBuffer[9] = float4(4.047619,-3.047619,2.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(-1024.000000,-1024.000000,-1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(-0.000977,-0.000977,-0.000977,0.357143);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.357143,0.357143,0.714286,-0.285714);//(Unknown)
	Material.PreshaderBuffer[15] = float4(3.000000,-2.000000,3.352381,1.723429);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1764.791260,1764.791260,1764.791260,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1764.791260,1764.791260,1764.791260,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(-1764.791260,-1764.791260,-1764.791260,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(-0.000567,-0.000567,-0.000567,0.419048);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.419048,0.419048,0.838096,-0.161904);//(Unknown)
	Material.PreshaderBuffer[21] = float4(4.352381,-3.352381,6.114286,0.685714);//(Unknown)
	Material.PreshaderBuffer[22] = float4(-0.314286,0.314286,0.125714,-0.274286);//(Unknown)
	Material.PreshaderBuffer[23] = float4(7.114286,-6.114286,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.083333,0.082550,0.025720,1.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(2.000000,0.800000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(819.200012,819.200012,819.200012,0.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(819.200012,819.200012,819.200012,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(-819.200012,-819.200012,-819.200012,0.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(-0.001221,-0.001221,-0.001221,0.320000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(0.320000,0.320000,0.640000,-0.360000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(3.000000,-2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.083333,0.082550,0.025720,1.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(3509024685661995663360.000000,0.000000,120734089216.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[51] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[52] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[53] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[54] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[55] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[56] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[57] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[58] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[59] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[60] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[61] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[62] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[63] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[64] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[65] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[66] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[67] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[68] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[69] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[70] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[71] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[72] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[73] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[74] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[75] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[76] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[77] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[78] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[79] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[80] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[81] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat Local1 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 1);
	MaterialFloat4 Local2 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,sampler_Material_Texture2D_0,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local3 = MaterialStoreTexSample(Parameters, Local2, 1);
	MaterialFloat4 Local4 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_1,sampler_Material_Texture2D_1,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local5 = MaterialStoreTexSample(Parameters, Local4, 1);
	MaterialFloat3 Local6 = lerp(Local4.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[1].x);
	MaterialFloat Local7 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 2);
	MaterialFloat4 Local8 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,sampler_Material_Texture2D_2,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local9 = MaterialStoreTexSample(Parameters, Local8, 2);
	MaterialFloat Local10 = (Local8.g + Material.PreshaderBuffer[2].z);
	MaterialFloat Local11 = lerp(Material.PreshaderBuffer[3].x,Material.PreshaderBuffer[2].w,Local10);
	MaterialFloat Local12 = saturate(Local11);
	MaterialFloat Local13 = saturate(Local12.r);
	FLWCVector3 Local14 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local15 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[7].xyz));
	FLWCVector2 Local16 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local15)), LWCGetZ(DERIV_BASE_VALUE(Local15)));
	MaterialFloat2 Local17 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local16), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local18 = MaterialStoreTexCoordScale(Parameters, Local17, 2);
	MaterialFloat4 Local19 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local17));
	MaterialFloat Local20 = MaterialStoreTexSample(Parameters, Local19, 2);
	FLWCVector2 Local21 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local15)), LWCGetZ(DERIV_BASE_VALUE(Local15)));
	MaterialFloat2 Local22 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local21), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local23 = MaterialStoreTexCoordScale(Parameters, Local22, 2);
	MaterialFloat4 Local24 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local22));
	MaterialFloat Local25 = MaterialStoreTexSample(Parameters, Local24, 2);
	MaterialFloat Local26 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local27 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local26);
	MaterialFloat Local28 = saturate(Local27);
	MaterialFloat3 Local29 = lerp(Local19.rgb,Local24.rgb,Local28.r.r);
	FLWCVector2 Local30 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local15)), LWCGetY(DERIV_BASE_VALUE(Local15)));
	MaterialFloat2 Local31 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local30), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local32 = MaterialStoreTexCoordScale(Parameters, Local31, 2);
	MaterialFloat4 Local33 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local31));
	MaterialFloat Local34 = MaterialStoreTexSample(Parameters, Local33, 2);
	MaterialFloat Local35 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local36 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local35);
	MaterialFloat Local37 = saturate(Local36);
	MaterialFloat3 Local38 = lerp(Local29,Local33.rgb,Local37.r.r);
	MaterialFloat Local39 = (Local38.b + Material.PreshaderBuffer[8].w);
	MaterialFloat Local40 = lerp(Material.PreshaderBuffer[9].y,Material.PreshaderBuffer[9].x,Local39);
	MaterialFloat Local41 = saturate(Local40);
	MaterialFloat Local42 = saturate(Local41.r);
	MaterialFloat Local43 = (Local13 + Local42);
	MaterialFloat Local44 = saturate(Local43);
	MaterialFloat Local45 = saturate(Local44);
	FLWCVector3 Local46 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[13].xyz));
	FLWCVector2 Local47 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local46)), LWCGetZ(DERIV_BASE_VALUE(Local46)));
	MaterialFloat2 Local48 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local47), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local49 = MaterialStoreTexCoordScale(Parameters, Local48, 2);
	MaterialFloat4 Local50 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local48));
	MaterialFloat Local51 = MaterialStoreTexSample(Parameters, Local50, 2);
	FLWCVector2 Local52 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local46)), LWCGetZ(DERIV_BASE_VALUE(Local46)));
	MaterialFloat2 Local53 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local52), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local54 = MaterialStoreTexCoordScale(Parameters, Local53, 2);
	MaterialFloat4 Local55 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local53));
	MaterialFloat Local56 = MaterialStoreTexSample(Parameters, Local55, 2);
	MaterialFloat4 Local57 = lerp(MaterialFloat4(Local50.rgb,Local50.a),MaterialFloat4(Local55.rgb,Local55.a),Local28.r.r);
	FLWCVector2 Local58 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local46)), LWCGetY(DERIV_BASE_VALUE(Local46)));
	MaterialFloat2 Local59 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local58), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local60 = MaterialStoreTexCoordScale(Parameters, Local59, 2);
	MaterialFloat4 Local61 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local59));
	MaterialFloat Local62 = MaterialStoreTexSample(Parameters, Local61, 2);
	MaterialFloat4 Local63 = lerp(Local57,MaterialFloat4(Local61.rgb,Local61.a),Local37.r.r);
	MaterialFloat Local64 = (Local63.a + Material.PreshaderBuffer[14].w);
	MaterialFloat Local65 = lerp(Material.PreshaderBuffer[15].y,Material.PreshaderBuffer[15].x,Local64);
	MaterialFloat Local66 = saturate(Local65);
	MaterialFloat Local67 = saturate(Local66.r);
	MaterialFloat Local68 = (Local45 + Local67);
	MaterialFloat Local69 = saturate(Local68);
	FLWCVector3 Local70 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[19].xyz));
	FLWCVector2 Local71 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local70)), LWCGetZ(DERIV_BASE_VALUE(Local70)));
	MaterialFloat2 Local72 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local71), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local73 = MaterialStoreTexCoordScale(Parameters, Local72, 2);
	MaterialFloat4 Local74 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local72));
	MaterialFloat Local75 = MaterialStoreTexSample(Parameters, Local74, 2);
	FLWCVector2 Local76 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local70)), LWCGetZ(DERIV_BASE_VALUE(Local70)));
	MaterialFloat2 Local77 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local76), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local78 = MaterialStoreTexCoordScale(Parameters, Local77, 2);
	MaterialFloat4 Local79 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local77));
	MaterialFloat Local80 = MaterialStoreTexSample(Parameters, Local79, 2);
	MaterialFloat3 Local81 = lerp(Local74.rgb,Local79.rgb,Local28.r.r);
	FLWCVector2 Local82 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local70)), LWCGetY(DERIV_BASE_VALUE(Local70)));
	MaterialFloat2 Local83 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local82), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local84 = MaterialStoreTexCoordScale(Parameters, Local83, 2);
	MaterialFloat4 Local85 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local83));
	MaterialFloat Local86 = MaterialStoreTexSample(Parameters, Local85, 2);
	MaterialFloat3 Local87 = lerp(Local81,Local85.rgb,Local37.r.r);
	MaterialFloat Local88 = (Local87.b + Material.PreshaderBuffer[20].w);
	MaterialFloat Local89 = lerp(Material.PreshaderBuffer[21].y,Material.PreshaderBuffer[21].x,Local88);
	MaterialFloat Local90 = saturate(Local89);
	MaterialFloat Local91 = saturate(Local90.r);
	MaterialFloat4 Local92 = Parameters.VertexColor;
	MaterialFloat Local93 = DERIV_BASE_VALUE(Local92).a;
	MaterialFloat Local94 = (Local87.b + DERIV_BASE_VALUE(Local93));
	MaterialFloat Local95 = saturate(Local94);
	MaterialFloat Local96 = (Local95 + Material.PreshaderBuffer[22].w);
	MaterialFloat Local97 = lerp(Material.PreshaderBuffer[23].y,Material.PreshaderBuffer[23].x,Local96);
	MaterialFloat Local98 = saturate(Local97);
	MaterialFloat Local99 = saturate(Local98.r);
	MaterialFloat3 Local100 = lerp(((MaterialFloat3)Local91),MaterialFloat3(0.00000000,0.00000000,0.00000000),Local99);
	MaterialFloat3 Local101 = saturate(Local100);
	MaterialFloat3 Local102 = (((MaterialFloat3)Local69) + Local101);
	MaterialFloat3 Local103 = saturate(Local102);
	MaterialFloat3 Local104 = lerp(Local2.rgb,Local6,Local103);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local104;


#if TEMPLATE_USES_STRATA
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL
#if SIMPLE_FORWARD_SHADING
	Parameters.WorldNormal = float3(0, 0, 1);
#endif

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat3 Local105 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[24].xyz,Material.PreshaderBuffer[23].z);
	MaterialFloat Local106 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local107 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local108 = MaterialStoreTexSample(Parameters, Local107, 4);
	MaterialFloat3 Local109 = (Local107.rgb * Material.PreshaderBuffer[26].xyz);
	MaterialFloat3 Local110 = (Local107.rgb * Material.PreshaderBuffer[28].xyz);
	MaterialFloat Local111 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local112 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local113 = MaterialStoreTexSample(Parameters, Local112, 0);
	MaterialFloat3 Local114 = lerp(Local109,Local110,Local112.b);
	MaterialFloat Local115 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local116 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,sampler_Material_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local117 = MaterialStoreTexSample(Parameters, Local116, 8);
	MaterialFloat3 Local118 = (Local116.rgb * Material.PreshaderBuffer[30].xyz);
	MaterialFloat3 Local119 = lerp(Local114,Local118,Local103);
	FLWCVector3 Local120 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[36].xyz));
	FLWCVector2 Local121 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local120)), LWCGetZ(DERIV_BASE_VALUE(Local120)));
	MaterialFloat2 Local122 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local121), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local123 = MaterialStoreTexCoordScale(Parameters, Local122, 2);
	MaterialFloat4 Local124 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local122));
	MaterialFloat Local125 = MaterialStoreTexSample(Parameters, Local124, 2);
	FLWCVector2 Local126 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local120)), LWCGetZ(DERIV_BASE_VALUE(Local120)));
	MaterialFloat2 Local127 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local126), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local128 = MaterialStoreTexCoordScale(Parameters, Local127, 2);
	MaterialFloat4 Local129 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local127));
	MaterialFloat Local130 = MaterialStoreTexSample(Parameters, Local129, 2);
	MaterialFloat3 Local131 = lerp(Local124.rgb,Local129.rgb,Local28.r.r);
	FLWCVector2 Local132 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local120)), LWCGetY(DERIV_BASE_VALUE(Local120)));
	MaterialFloat2 Local133 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local132), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local134 = MaterialStoreTexCoordScale(Parameters, Local133, 2);
	MaterialFloat4 Local135 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local133));
	MaterialFloat Local136 = MaterialStoreTexSample(Parameters, Local135, 2);
	MaterialFloat3 Local137 = lerp(Local131,Local135.rgb,Local37.r.r);
	MaterialFloat Local138 = (Local137.b + Material.PreshaderBuffer[37].w);
	MaterialFloat Local139 = lerp(Material.PreshaderBuffer[38].y,Material.PreshaderBuffer[38].x,Local138);
	MaterialFloat Local140 = saturate(Local139);
	MaterialFloat Local141 = saturate(Local140.r);
	MaterialFloat Local142 = saturate(Local141);
	MaterialFloat3 Local143 = lerp(Local119,Material.PreshaderBuffer[39].xyz,Local142);
	MaterialFloat Local144 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local145 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local146 = MaterialStoreTexSample(Parameters, Local145, 7);
	MaterialFloat4 Local147 = lerp(Local112.rgba,Local145.rgba,MaterialFloat4(MaterialFloat3(MaterialFloat2(Local103.x,Local103.x),Local103.x),Local103.x));
	MaterialFloat Local148 = (Local147.a * Material.PreshaderBuffer[39].w);
	MaterialFloat3 Local149 = lerp(MaterialFloat3(1.00000000,1.00000000,1.00000000),((MaterialFloat3)Local147.g),Material.PreshaderBuffer[40].x);

	PixelMaterialInputs.EmissiveColor = Local105;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local143;
	PixelMaterialInputs.Metallic = Local147.r;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local148;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local104;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local149;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}

#define UnityObjectToWorldDir TransformObjectToWorld
void SurfaceReplacement( Input In, out SurfaceOutputStandard o )
{
	InitializeExpressions();

	float3 Z3 = float3( 0, 0, 0 );
	float4 Z4 = float4( 0, 0, 0, 0 );

	float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );

	float3 UnrealNormal = In.normal2;

	View_MaterialTextureBilinearWrapedSampler = SamplerState_Linear_Repeat;
	View_MaterialTextureBilinearClampedSampler = SamplerState_Linear_Clamp;

	Material_Wrap_WorldGroupSettings = SamplerState_Linear_Repeat;
	Material_Clamp_WorldGroupSettings = SamplerState_Linear_Clamp;

	FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
#if NUM_TEX_COORD_INTERPOLATORS > 0			
	Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, In.uv_MainTex.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 1
	Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, In.uv2_Material_Texture2D_0.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, In.uv_MainTex.y );
	}
#endif
	Parameters.VertexColor = In.color;
	Parameters.WorldNormal = UnrealNormal;
	Parameters.ReflectionVector = half3( 0, 0, 1 );
	//Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
	Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
	Parameters.LightVector = half3( 0, 0, 0 );
	float4 screenpos = In.screenPos;
	screenpos /= screenpos.w;
	//screenpos.y = 1 - screenpos.y;
	Parameters.SvPosition = float4( screenpos.x, screenpos.y, 0, 0 );
	Parameters.ScreenPosition = Parameters.SvPosition;

	Parameters.UnMirrored = 1;

	Parameters.TwoSidedSign = 1;


	float3 InWorldNormal = UnrealNormal;
	float4 InTangent = In.tangent;
	float4 tangentWorld = float4( UnityObjectToWorldDir( InTangent.xyz ), InTangent.w );
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( Z3, Z3, InWorldNormal );// tangentToWorld;

	//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
	//but watch out for any computation that might get skewed as a side effect
	UnrealWorldPos = UnrealWorldPos * 100;
	UnrealWorldPos = UnrealWorldPos.xzy;
	Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
	Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
	Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up

	//Parameters.TangentToWorld = half3x3( float3( 1, 1, 1 ), float3( 1, 1, 1 ), UnrealNormal.xyz );
	Parameters.AbsoluteWorldPosition = UnrealWorldPos;
	Parameters.WorldPosition_CamRelative = UnrealWorldPos;
	Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

	Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
	Parameters.LightingPositionOffset = float3( 0, 0, 0 );

	Parameters.AOMaterialMask = 0;

	Parameters.Particle.RelativeTime = 0;
	Parameters.Particle.MotionBlurFade;
	Parameters.Particle.Random = 0;
	Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
	Parameters.Particle.Color = half4( 1, 1, 1, 1 );
	Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
	Parameters.Particle.MacroUV = half4( 0, 0, 1, 1 );
	Parameters.Particle.DynamicParameter = half4( 0, 0, 0, 0 );
	Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
	Parameters.Particle.Size = float2( 1, 1 );
	Parameters.TexCoordScalesParams = float2( 0, 0 );
	Parameters.PrimitiveId = 0;
	Parameters.VirtualTextureFeedback = 0;

	FPixelMaterialInputs PixelMaterialInputs = (FPixelMaterialInputs)0;
	PixelMaterialInputs.Normal = float3( 0, 0, 1 );
	PixelMaterialInputs.ShadingModel = 0;
	PixelMaterialInputs.FrontMaterial = 0;

	//Extra
	View.GameTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
	View.MaterialTextureMipBias = 0.0;
	View.TemporalAAParams = float2( 0, 0 );
	View.ViewRectMin = float2( 0, 0 );
	View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
	View.MaterialTextureDerivativeMultiply = 1.0f;
	View.StateFrameIndexMod8 = 0;

	for( int i2 = 0; i2 < 40; i2++ )
		View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

	uint PrimitiveBaseOffset = Parameters.PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = unity_ObjectToWorld[ 0 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = unity_ObjectToWorld[ 1 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = unity_ObjectToWorld[ 2 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = unity_ObjectToWorld[ 3 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = unity_WorldToObject[ 0 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = unity_WorldToObject[ 1 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = unity_WorldToObject[ 2 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = unity_WorldToObject[ 3 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = unity_WorldToObject[ 0 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = unity_WorldToObject[ 1 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = unity_WorldToObject[ 2 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = unity_WorldToObject[ 3 ];//PreviousLocalToWorld

	#ifdef UE5
		ResolvedView.WorldCameraOrigin = LWCPromote( _WorldSpaceCameraPos.xyz );
	#else
		ResolvedView.WorldCameraOrigin = _WorldSpaceCameraPos.xyz;
	#endif
	ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
	ResolvedView.TranslatedWorldToView = unity_MatrixV;
	ResolvedView.TranslatedWorldToCameraView = unity_MatrixV;
	ResolvedView.ViewToTranslatedWorld = unity_MatrixInvV;
	ResolvedView.CameraViewToTranslatedWorld = unity_MatrixInvV;
	Primitive.WorldToLocal = unity_WorldToObject;
	Primitive.LocalToWorld = unity_ObjectToWorld;
	CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

	#define HAS_WORLDSPACE_NORMAL 0
	#if HAS_WORLDSPACE_NORMAL
		PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( Parameters.TangentToWorld ) ) );
	#endif

	o.Albedo = PixelMaterialInputs.BaseColor.rgb;
	o.Alpha = PixelMaterialInputs.Opacity;
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}