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
	float4 PreshaderBuffer[908 ];
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
	Material.PreshaderBuffer[1] = float4(0.000000,2.000000,0.300000,0.300000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.300000,0.600000,-0.400000,3.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(-2.000000,20.000000,0.961905,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(984.990723,984.990723,984.990723,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(984.990723,984.990723,984.990723,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(-984.990723,-984.990723,-984.990723,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(-0.001015,-0.001015,-0.001015,0.352381);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.352381,0.352381,0.704762,-0.295238);//(Unknown)
	Material.PreshaderBuffer[9] = float4(21.000000,-20.000000,20.000000,0.619047);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.619047,0.619047,1.238094,0.238094);//(Unknown)
	Material.PreshaderBuffer[11] = float4(21.000000,-20.000000,20.000000,0.771524);//(Unknown)
	Material.PreshaderBuffer[12] = float4(790.040588,790.040588,790.040588,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(790.040588,790.040588,790.040588,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(-790.040588,-790.040588,-790.040588,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(-0.001266,-0.001266,-0.001266,0.369048);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.369048,0.369048,0.738096,-0.261904);//(Unknown)
	Material.PreshaderBuffer[17] = float4(21.000000,-20.000000,20.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(2048.000000,2048.000000,2048.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(2048.000000,2048.000000,2048.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(-2048.000000,-2048.000000,-2048.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-0.000488,-0.000488,-0.000488,0.523809);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.523809,0.523809,1.047618,0.047618);//(Unknown)
	Material.PreshaderBuffer[23] = float4(21.000000,-20.000000,20.000000,0.342857);//(Unknown)
	Material.PreshaderBuffer[24] = float4(-0.657143,0.657143,0.262857,-0.137143);//(Unknown)
	Material.PreshaderBuffer[25] = float4(21.000000,-20.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.020833,0.018799,0.007412,1.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(1024.000000,1024.000000,1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(-1024.000000,-1024.000000,-1024.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(-0.000977,-0.000977,-0.000977,0.185714);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.185714,0.185714,0.371428,-0.628572);//(Unknown)
	Material.PreshaderBuffer[40] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(0.020833,0.018799,0.007412,1.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(2386713535232836626284544.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(-0.000000,0.000000,3509024685661995663360.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(3509024685661995663360.000000,0.000000,120734089216.000000,0.000000);//(Unknown)
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
	Material.PreshaderBuffer[82] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[83] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[84] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[85] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[86] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[87] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[88] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[89] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat Local45 = (1.00000000 - Local8.r);
	MaterialFloat Local46 = (Local45 + Material.PreshaderBuffer[10].w);
	MaterialFloat Local47 = lerp(Material.PreshaderBuffer[11].y,Material.PreshaderBuffer[11].x,Local46);
	MaterialFloat Local48 = saturate(Local47);
	MaterialFloat Local49 = (Local44 - Local48.r);
	MaterialFloat Local50 = saturate(Local49);
	FLWCVector3 Local51 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[15].xyz));
	FLWCVector2 Local52 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local51)), LWCGetZ(DERIV_BASE_VALUE(Local51)));
	MaterialFloat2 Local53 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local52), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local54 = MaterialStoreTexCoordScale(Parameters, Local53, 2);
	MaterialFloat4 Local55 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local53));
	MaterialFloat Local56 = MaterialStoreTexSample(Parameters, Local55, 2);
	FLWCVector2 Local57 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local51)), LWCGetZ(DERIV_BASE_VALUE(Local51)));
	MaterialFloat2 Local58 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local57), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local59 = MaterialStoreTexCoordScale(Parameters, Local58, 2);
	MaterialFloat4 Local60 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local58));
	MaterialFloat Local61 = MaterialStoreTexSample(Parameters, Local60, 2);
	MaterialFloat4 Local62 = lerp(MaterialFloat4(Local55.rgb,Local55.a),MaterialFloat4(Local60.rgb,Local60.a),Local28.r.r);
	FLWCVector2 Local63 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local51)), LWCGetY(DERIV_BASE_VALUE(Local51)));
	MaterialFloat2 Local64 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local63), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local65 = MaterialStoreTexCoordScale(Parameters, Local64, 2);
	MaterialFloat4 Local66 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local64));
	MaterialFloat Local67 = MaterialStoreTexSample(Parameters, Local66, 2);
	MaterialFloat4 Local68 = lerp(Local62,MaterialFloat4(Local66.rgb,Local66.a),Local37.r.r);
	MaterialFloat Local69 = (Local68.a + Material.PreshaderBuffer[16].w);
	MaterialFloat Local70 = lerp(Material.PreshaderBuffer[17].y,Material.PreshaderBuffer[17].x,Local69);
	MaterialFloat Local71 = saturate(Local70);
	MaterialFloat Local72 = saturate(Local71.r);
	MaterialFloat Local73 = (Local50 + Local72);
	MaterialFloat Local74 = saturate(Local73);
	FLWCVector3 Local75 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[21].xyz));
	FLWCVector2 Local76 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local75)), LWCGetZ(DERIV_BASE_VALUE(Local75)));
	MaterialFloat2 Local77 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local76), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local78 = MaterialStoreTexCoordScale(Parameters, Local77, 2);
	MaterialFloat4 Local79 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local77));
	MaterialFloat Local80 = MaterialStoreTexSample(Parameters, Local79, 2);
	FLWCVector2 Local81 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local75)), LWCGetZ(DERIV_BASE_VALUE(Local75)));
	MaterialFloat2 Local82 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local81), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local83 = MaterialStoreTexCoordScale(Parameters, Local82, 2);
	MaterialFloat4 Local84 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local82));
	MaterialFloat Local85 = MaterialStoreTexSample(Parameters, Local84, 2);
	MaterialFloat3 Local86 = lerp(Local79.rgb,Local84.rgb,Local28.r.r);
	FLWCVector2 Local87 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local75)), LWCGetY(DERIV_BASE_VALUE(Local75)));
	MaterialFloat2 Local88 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local87), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local89 = MaterialStoreTexCoordScale(Parameters, Local88, 2);
	MaterialFloat4 Local90 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local88));
	MaterialFloat Local91 = MaterialStoreTexSample(Parameters, Local90, 2);
	MaterialFloat3 Local92 = lerp(Local86,Local90.rgb,Local37.r.r);
	MaterialFloat Local93 = (Local92.b + Material.PreshaderBuffer[22].w);
	MaterialFloat Local94 = lerp(Material.PreshaderBuffer[23].y,Material.PreshaderBuffer[23].x,Local93);
	MaterialFloat Local95 = saturate(Local94);
	MaterialFloat Local96 = saturate(Local95.r);
	MaterialFloat4 Local97 = Parameters.VertexColor;
	MaterialFloat Local98 = DERIV_BASE_VALUE(Local97).a;
	MaterialFloat Local99 = (Local92.b + DERIV_BASE_VALUE(Local98));
	MaterialFloat Local100 = saturate(Local99);
	MaterialFloat Local101 = (Local100 + Material.PreshaderBuffer[24].w);
	MaterialFloat Local102 = lerp(Material.PreshaderBuffer[25].y,Material.PreshaderBuffer[25].x,Local101);
	MaterialFloat Local103 = saturate(Local102);
	MaterialFloat Local104 = saturate(Local103.r);
	MaterialFloat3 Local105 = lerp(((MaterialFloat3)Local96),MaterialFloat3(0.00000000,0.00000000,0.00000000),Local104);
	MaterialFloat3 Local106 = saturate(Local105);
	MaterialFloat3 Local107 = (((MaterialFloat3)Local74) + Local106);
	MaterialFloat3 Local108 = saturate(Local107);
	MaterialFloat3 Local109 = lerp(Local2.rgb,Local6,Local108);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local109;


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
	MaterialFloat3 Local110 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[26].xyz,Material.PreshaderBuffer[25].z);
	MaterialFloat Local111 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local112 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local113 = MaterialStoreTexSample(Parameters, Local112, 4);
	MaterialFloat3 Local114 = (Local112.rgb * Material.PreshaderBuffer[28].xyz);
	MaterialFloat3 Local115 = (Local112.rgb * Material.PreshaderBuffer[30].xyz);
	MaterialFloat Local116 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local117 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local118 = MaterialStoreTexSample(Parameters, Local117, 0);
	MaterialFloat3 Local119 = lerp(Local114,Local115,Local117.b);
	MaterialFloat Local120 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local121 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,sampler_Material_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local122 = MaterialStoreTexSample(Parameters, Local121, 8);
	MaterialFloat3 Local123 = (Local121.rgb * Material.PreshaderBuffer[32].xyz);
	MaterialFloat3 Local124 = lerp(Local119,Local123,Local108);
	FLWCVector3 Local125 = LWCMultiply(DERIV_BASE_VALUE(Local14), LWCPromote(Material.PreshaderBuffer[38].xyz));
	FLWCVector2 Local126 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local125)), LWCGetZ(DERIV_BASE_VALUE(Local125)));
	MaterialFloat2 Local127 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local126), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local128 = MaterialStoreTexCoordScale(Parameters, Local127, 2);
	MaterialFloat4 Local129 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local127));
	MaterialFloat Local130 = MaterialStoreTexSample(Parameters, Local129, 2);
	FLWCVector2 Local131 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local125)), LWCGetZ(DERIV_BASE_VALUE(Local125)));
	MaterialFloat2 Local132 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local131), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local133 = MaterialStoreTexCoordScale(Parameters, Local132, 2);
	MaterialFloat4 Local134 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local132));
	MaterialFloat Local135 = MaterialStoreTexSample(Parameters, Local134, 2);
	MaterialFloat3 Local136 = lerp(Local129.rgb,Local134.rgb,Local28.r.r);
	FLWCVector2 Local137 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local125)), LWCGetY(DERIV_BASE_VALUE(Local125)));
	MaterialFloat2 Local138 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local137), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local139 = MaterialStoreTexCoordScale(Parameters, Local138, 2);
	MaterialFloat4 Local140 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local138));
	MaterialFloat Local141 = MaterialStoreTexSample(Parameters, Local140, 2);
	MaterialFloat3 Local142 = lerp(Local136,Local140.rgb,Local37.r.r);
	MaterialFloat Local143 = (Local142.b + Material.PreshaderBuffer[39].w);
	MaterialFloat Local144 = lerp(Material.PreshaderBuffer[40].y,Material.PreshaderBuffer[40].x,Local143);
	MaterialFloat Local145 = saturate(Local144);
	MaterialFloat Local146 = saturate(Local145.r);
	MaterialFloat Local147 = saturate(Local146);
	MaterialFloat3 Local148 = lerp(Local124,Material.PreshaderBuffer[41].xyz,Local147);
	MaterialFloat Local149 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local150 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local151 = MaterialStoreTexSample(Parameters, Local150, 7);
	MaterialFloat4 Local152 = lerp(Local117.rgba,Local150.rgba,MaterialFloat4(MaterialFloat3(MaterialFloat2(Local108.x,Local108.x),Local108.x),Local108.x));
	MaterialFloat Local153 = (Local152.a * Material.PreshaderBuffer[41].w);
	MaterialFloat3 Local154 = lerp(MaterialFloat3(1.00000000,1.00000000,1.00000000),((MaterialFloat3)Local152.g),Material.PreshaderBuffer[42].x);

	PixelMaterialInputs.EmissiveColor = Local110;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local148;
	PixelMaterialInputs.Metallic = Local152.r;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local153;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local109;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local154;
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