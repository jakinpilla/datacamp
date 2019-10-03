# Calculate node 0 value: node_0_value
node_0_value = (____ * ____).____

# Calculate node 1 value: node_1_value
node_1_value = ____

# Put node values into array: hidden_layer_outputs
hidden_layer_outputs = np.array([node_0_value, node_1_value])

# Calculate output: output
output = ____

# Print output
print(output)


def relu(input):
    '''Define your relu activation function here'''
    # Calculate the value for the output of the relu function: output
    output = max(____, ____)
    
    # Return the value just calculated
    return(output)

# Calculate node 0 value: node_0_output
node_0_input = (input_data * weights['node_0']).sum()
node_0_output = ____

# Calculate node 1 value: node_1_output
node_1_input = (input_data * weights['node_1']).sum()
node_1_output = ____

# Put node values into array: hidden_layer_outputs
hidden_layer_outputs = np.array([node_0_output, node_1_output])

# Calculate model output (do not apply relu)
model_output = (hidden_layer_outputs * weights['output']).sum()

# Print model output
print(model_output)



# Define predict_with_network()
def predict_with_network(input_data_row, weights):

    # Calculate node 0 value
    node_0_input = ____
    node_0_output = ____

    # Calculate node 1 value
    node_1_input = ____
    node_1_output = ____

    # Put node values into array: hidden_layer_outputs
    hidden_layer_outputs = np.array([node_0_output, node_1_output])
    
    # Calculate model output
    input_to_final_layer = ____
    model_output = ____
    
    # Return model output
    return(model_output)


# Create empty list to store prediction results
results = []
for input_data_row in input_data:
    # Append prediction to results
    results.append(____)

# Print results
print(results)



def predict_with_network(input_data):
    # Calculate node 0 in the first hidden layer
    node_0_0_input = (____ * ____).sum()
    node_0_0_output = relu(____)

    # Calculate node 1 in the first hidden layer
    node_0_1_input = ____
    node_0_1_output = ____

    # Put node values into array: hidden_0_outputs
    hidden_0_outputs = np.array([node_0_0_output, node_0_1_output])
    
    # Calculate node 0 in the second hidden layer
    node_1_0_input = ____
    node_1_0_output = ____

    # Calculate node 1 in the second hidden layer
    node_1_1_input = ____
    node_1_1_output = ____

    # Put node values into array: hidden_1_outputs
    hidden_1_outputs = np.array([node_1_0_output, node_1_1_output])

    # Calculate model output: model_output
    model_output = ____
    
    # Return model_output
    return(model_output)

output = predict_with_network(input_data)
print(output)






