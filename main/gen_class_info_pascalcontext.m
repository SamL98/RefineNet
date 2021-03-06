
function class_info=gen_class_info_pascalcontext()

class_info=[];

class_names=load('./pascalcontext_class_names.mat');
class_names=class_names.class_names;
%class_names=class_names(2:end);

class_info.class_names = class_names;

class_info.class_label_values=uint8([0: (length(class_names)-1)]); % default 0-(nc-1)
class_info.background_label_value=uint8(0); % default is 0
class_info.void_label_values=uint8(255); % default is 255

class_info.mask_cmap = VOClabelcolormap(256);

class_info=process_class_info(class_info);

end