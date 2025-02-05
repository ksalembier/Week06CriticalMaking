// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "dirtyShader"
{
	Properties
	{
		_dirtyTextureClean("dirtyTextureClean", 2D) = "white" {}
		_dirtyTextureDirty("dirtyTextureDirty", 2D) = "white" {}
		_dirtyMask("dirtyMask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _dirtyTextureClean;
		uniform float4 _dirtyTextureClean_ST;
		uniform sampler2D _dirtyMask;
		uniform float4 _dirtyMask_ST;
		uniform sampler2D _dirtyTextureDirty;
		uniform float4 _dirtyTextureDirty_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_dirtyTextureClean = i.uv_texcoord * _dirtyTextureClean_ST.xy + _dirtyTextureClean_ST.zw;
			float2 uv_dirtyMask = i.uv_texcoord * _dirtyMask_ST.xy + _dirtyMask_ST.zw;
			float4 tex2DNode5 = tex2D( _dirtyMask, uv_dirtyMask );
			float2 uv_dirtyTextureDirty = i.uv_texcoord * _dirtyTextureDirty_ST.xy + _dirtyTextureDirty_ST.zw;
			o.Albedo = ( ( tex2D( _dirtyTextureClean, uv_dirtyTextureClean ) * ( 1.0 - tex2DNode5.g ) ) + ( tex2D( _dirtyTextureDirty, uv_dirtyTextureDirty ) * tex2DNode5 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.SamplerNode;5;-896,480;Inherit;True;Property;_dirtyMask;dirtyMask;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;3;-898.4216,-36.25641;Inherit;True;Property;_dirtyTextureClean;dirtyTextureClean;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;4;-898.4216,233.4357;Inherit;True;Property;_dirtyTextureDirty;dirtyTextureDirty;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;7;-496,224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-471.1107,350.6499;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-266.0338,85.54773;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-19.41565,201.6877;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;96,208;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;dirtyShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;2
WireConnection;8;0;4;0
WireConnection;8;1;5;0
WireConnection;9;0;3;0
WireConnection;9;1;7;0
WireConnection;10;0;9;0
WireConnection;10;1;8;0
WireConnection;2;0;10;0
ASEEND*/
//CHKSM=FCBA7090113CB7255488DA258BD4F54D24DFCD62