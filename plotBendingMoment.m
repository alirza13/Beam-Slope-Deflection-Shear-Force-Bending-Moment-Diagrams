function plotBendingMoment(beamType, beamLength, beamWidth, beamHeight, beamMaterialType,elasticMod,inertia, pointForce, udl, windSpeed, fluidType)
    densityOfAir = 1.225;
    densityOfWater = 997;
    densityOfHoney = 1400;
    gravitationalAcceleration = 9.8;
    modElasticitySteel = 200 * power(10,9);
    modElasticityAluminum = 68.9  * power(10,9);
    modElasticityPlatinum = 172 * power(10,9);
    modElasticityChosen = elasticMod;
        
    area  = beamLength * beamWidth;
    submergedVolume = beamLength * beamWidth * beamHeight;
    if strcmp(beamMaterialType,'steel')
        modElasticityChosen = modElasticitySteel;
    elseif strcmp(beamMaterialType,'aluminum')
        modElasticityChosen = modElasticityAluminum;
    elseif strcmp(beamMaterialType,'platinum')
        modElasticityChosen = modElasticityPlatinum;
    end
    if (windSpeed)
        windLoad = 0.5 * densityOfAir * (windSpeed / 3.6) ^ 2 * area;
        uniformLoad = udl + windLoad;
    else
        uniformLoad = udl;
    end
    if strcmp(fluidType,'honey')
        buoyancyLoad = densityOfHoney * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    elseif strcmp(fluidType,'water')
        buoyancyLoad = densityOfWater * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    end
    if (inertia)
        secondMomentArea = inertia;        
    else
        secondMomentArea = beamWidth * power(beamHeight,3) / 12;
    end    
    x = 0:0.0000001:beamLength;
    m = (uniformLoad * beamLength + pointForce) * x - ((uniformLoad * beamLength * beamLength/2) + pointForce * beamLength) - (uniformLoad* x.^2) / 2;
    
    figure;
    hold on
%     sgtitle('10N Point Load, 50 N/m, Immersed in Honey')
    plot(x,m);
%     plot(0,0,'r>','MarkerSize',10);
    title('Bending moment diagram');
%     xlim([-1 beamLength+1])
%     ylim([-0.000000001+1.5*maxDef 0.000000001+(-2.5)*maxDef])
    xlabel('meter(m)');
    ylabel('N.m');
end