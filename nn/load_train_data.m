function [x, y] = load_train_data()
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_tiny';
x = [];
y = [];
input_images = dir(sprintf('%s/*.png', train_images_directory));
for img = input_images'
    feature_vector = create_feature_vector(train_images_directory, img.name);
    x = [x; feature_vector];
    target_vector = create_target_vector(train_cleaned_images_directory, img.name);
    y = [y; target_vector];
end
end