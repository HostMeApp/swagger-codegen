package io.swagger.codegen.languages;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.File;

import io.swagger.codegen.SupportingFile;

import io.swagger.codegen.CliOption;
import io.swagger.codegen.CodegenParameter;
import io.swagger.codegen.SupportingFile;
import io.swagger.models.properties.ArrayProperty;
import io.swagger.models.properties.BooleanProperty;
import io.swagger.models.properties.FileProperty;
import io.swagger.models.properties.MapProperty;
import io.swagger.models.properties.Property;

public class TypeScriptAngularClientCodegen extends AbstractTypeScriptClientCodegen {

	@Override
	public String getName() {
		return "typescript-angular";
	}

	@Override
	public String getHelp() {
		return "Generates a TypeScript AngularJS client library.";
	}

	@Override
    public void processOpts() {
        super.processOpts();
	    if (additionalProperties.containsKey("generateApis") && (Boolean)additionalProperties.get("generateApis"))
		{ 
            supportingFiles.add(new SupportingFile("api.d.mustache", "src" + File.separatorChar + apiPackage().replace('.', File.separatorChar), "api.ts"));
			supportingFiles.add(new SupportingFile("auth.mustache", "src" + File.separatorChar + apiPackage().replace('.', File.separatorChar), "auth.ts"));
            
            supportingFiles.add(new SupportingFile("AuthorizationService.mustache", "src/client/" , "AuthorizationService.ts"));
            supportingFiles.add(new SupportingFile("IApiConfig.mustache", "src/client/" , "IApiConfig.ts"));
		}
		
        if (additionalProperties.containsKey("generateModels") && (Boolean)additionalProperties.get("generateModels")) 
            supportingFiles.add(new SupportingFile("model.d.mustache", "src" + File.separatorChar + modelPackage().replace('.', File.separatorChar), "models.ts"));
        
        supportingFiles.add(new SupportingFile("git_push.sh.mustache", "", "git_push.sh"));
	    supportingFiles.add(new SupportingFile("git_push.mustache", "", "git_push.but"));
		supportingFiles.add(new SupportingFile("index.d.mustache", "src" + File.separatorChar, "index.ts"));
		
        //supportingFiles.add(new SupportingFile("gitignore.mustache", "", ".gitignore"));


	}
	
	public TypeScriptAngularClientCodegen() {
	    super();
	    outputFolder = "generated-code/typescript-angular";
	    modelTemplateFiles.put("model.mustache", ".ts");
	    apiTemplateFiles.put("api.mustache", ".ts");
	    embeddedTemplateDir = templateDir = "TypeScript-Angular";
	    typeMapping.put("Date","Date");
		apiPackage = "api";
        modelPackage = "model";
	}
	
	@Override
	public String apiFileFolder() {
		return outputFolder + "/src/" + apiPackage().replace('.', File.separatorChar);
	}

	@Override
	public String modelFileFolder() {
		return outputFolder + "/src/" + modelPackage().replace('.', File.separatorChar);
	}
	
	@Override
    public String getTypeDeclaration(Property p) {
        Property inner;
        if(p instanceof ArrayProperty) {
            ArrayProperty mp1 = (ArrayProperty)p;
            inner = mp1.getItems();
            return this.getSwaggerType(p) + "<" + this.getTypeDeclaration(inner) + ">";
        } else if(p instanceof MapProperty) {
            MapProperty mp = (MapProperty)p;
            inner = mp.getAdditionalProperties();
            return "{ [key: string]: " + this.getTypeDeclaration(inner) + "; }";
        } else {
            return p instanceof FileProperty ? "any" : super.getTypeDeclaration(p);
        }
    }

    @Override
    public String getSwaggerType(Property p) {
        String swaggerType = super.getSwaggerType(p);
        return addModelPrefix(swaggerType);
    }

    private String addModelPrefix(String swaggerType) {
        String type = null;
        if (typeMapping.containsKey(swaggerType)) {
            type = typeMapping.get(swaggerType);
            if (languageSpecificPrimitives.contains(type))
                return type;
        } else
            type = "models." + swaggerType;
        return type;
    }

    @Override
    public void postProcessParameter(CodegenParameter parameter) {
        super.postProcessParameter(parameter);
		if(parameter.isContainer == null || parameter.isContainer == false){
        	parameter.dataType = addModelPrefix(parameter.dataType);
		}
    }
}
